# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AlphabetalController, type: :controller do
  describe 'GET #show' do
    let!(:alphabetal) { create(:alphabetal) }
    it 'show 表示されること' do
      get :show, params: { id: 1 }
      expect(response.status).to eq 200
    end
  end
end
