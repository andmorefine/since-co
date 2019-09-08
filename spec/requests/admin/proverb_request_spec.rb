# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ProverbController, type: :request do
  describe 'GET #index' do
    subject { admin_member }
    context 'ログインできること' do
      it 'リダイレクトされること' do
        get '/admin/proverb'
        expect(response.body).to include 'redirected'
      end
      it '表示されること' do
        login_admin
        get '/admin/home'
        expect(response.body).to include 'andmorefine'
      end
    end
  end
end
