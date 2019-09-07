# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SocketsController, type: :request do
  describe 'GET #show' do
    it 'show 表示されること' do
      get '/socket'
      expect(response.status).to eq 200
    end
  end
end
