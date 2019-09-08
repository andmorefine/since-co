# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AlphabetalController, type: :request do
  describe 'GET #show' do
    it 'show 表示されること' do
      MAlphabetal.create(name: 'あ', created_at: Time.zone.now, updated_at: Time.zone.now)
      get '/alphabetal/1'
      expect(response.body).to include 'andmorefine'
    end
  end
end
