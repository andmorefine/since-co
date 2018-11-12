module API
  module V1
    class Root < Grape::API
      prefix 'api'
      version 'v1', using: :path
      format :json

      mount API::V1::Proverbs
    end
  end
end
