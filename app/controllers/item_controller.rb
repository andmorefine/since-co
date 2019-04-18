# frozen_string_literal: true

class ItemController < ApplicationController
  protect_from_forgery except: [:save_s3_images]

  AWS_S3_BUCKET = ENV['AWS_S3_BUCKET']
  AWS_ACCESS_KEY_ID = ENV['AWS_ACCESS_KEY_ID']
  AWS_SECRET_ACCESS_KEY = ENV['AWS_SECRET_ACCESS_KEY']

  def save_s3_images
    # アップロード後のファイル名
    acl = 'public-read'
    key = 'img' + params[:file_path] + params[:file_name] # アップロード先のパス + ファイル名
    ctype = params[:content_type]
    # ポリシー作成
    policy_document = {
      # 1分間のみ有効
      expiration: (Time.now + 1.minute).utc,
      conditions: [
        # アップロード先のS3バケット
        { bucket: AWS_S3_BUCKET },
        { acl: acl },
        { key: key },
        { 'Content-Type' => ctype },
        # アップロード可能なファイルのサイズ
        ['content-length-range', params[:size], params[:size]]
      ]
    }.to_json
    policy = Base64.encode64(policy_document).delete("\n")

    # signatureの作成
    signature = Base64.encode64(
      OpenSSL::HMAC.digest(
        OpenSSL::Digest.new('sha1'), AWS_SECRET_ACCESS_KEY, policy
      )
    ).delete("\n")

    # アップロードに必要な情報をJSON形式でクライアントに返す
    render json: {
      url: "//s3-ap-northeast-1.amazonaws.com/#{AWS_S3_BUCKET}/",
      form: {
        AWSAccessKeyId: AWS_ACCESS_KEY_ID,
        signature: signature,
        policy: policy,
        key: key,
        acl: acl,
        'Content-Type' => ctype
      }
    }
  end
end
