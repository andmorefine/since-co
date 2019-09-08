# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ProverbController, type: :controller do
  describe 'GET #index' do
    subject { admin_member }
    context 'ログインできること' do
      it 'リダイレクトされること' do
        get :show, params: { id: 1 }
        expect(response.status).to eq 302
      end
      it 'リダイレクトされること' do
        login_admin
        get :show, params: { id: 1 }
        expect(response.status).to eq 302
      end
    end
  end
end
