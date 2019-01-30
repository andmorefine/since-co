require 'rails_helper'

RSpec.describe ProverbController, type: :controller do

  describe 'GET #index' do
    it 'index 表示されること' do
      get :index
      expect(response.status).to eq 200
    end
  end

  describe 'GET #show' do
    it 'show 表示されること' do
      get :show, params: { id: 1 }
      expect(response.status).to eq 200
    end
  end

end
