# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ProverbController, type: :request do
  let!(:proverb) { create(:proverb) }

  describe 'GET #index' do
    it 'index 表示されること' do
      get '/proverb'
      expect(response.status).to eq 200
    end
  end

  describe 'GET #show' do
    it 'show 表示されること' do
      get '/proverb/1'
      expect(response.status).to eq 200
    end
  end
end
