require 'rails_helper'

RSpec.describe Proverb, type: :model do
  describe '.published' do
    it 'sample test' do
      proverb = Proverb.new(delete_flag: :draft)
      proverb.published
      expect(proverb.published?).not_to be_truthy
    end
  end
end
