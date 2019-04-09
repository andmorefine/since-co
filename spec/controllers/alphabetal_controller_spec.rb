# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AlphabetalController, type: :controller do
  describe 'GET #show' do
    it 'show 表示されること' do
      MAlphabetal.create(name: 'あ', created_at: Time.zone.now, updated_at: Time.zone.now)
      get :show, params: { id: 1 }
      expect(response.status).to eq 200
    end
  end
end
