# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Count, type: :model do
  it 'factory_bot test' do
    count = create(:count)
    expect(Count.count).to eq 1
  end
end
