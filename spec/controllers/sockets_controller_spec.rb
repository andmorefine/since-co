# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SocketsController, type: :controller do
  describe 'GET #show' do
    it 'show 表示されること' do
      get :show, params: { id: 1 }
      expect(response.status).to eq 200
    end
  end
end
