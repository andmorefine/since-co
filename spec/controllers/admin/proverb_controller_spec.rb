# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Admin::ProverbController, type: :controller do
  describe 'GET #index' do
    subject { admin_member }
    context 'ログインできること' do
      it '表示されること' do
        get :alphabetal
        expect(response.status).to eq 302
      end
      it '表示されること' do
        login_admin
        get :index
        expect(response.status).to eq 302
      end
    end
  end
end
