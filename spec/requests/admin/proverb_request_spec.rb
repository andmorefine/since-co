# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ProverbController, type: :request do
  describe 'GET #index' do
    subject { admin_member }
    context 'ログインできること' do
      it '表示されること' do
        get '/admin/proverb'
        expect(response.status).to eq 302
      end
      it '表示されること' do
        login_admin
        get '/admin/home'
        expect(response.status).to eq 200
      end
    end
  end
end
