require 'rails_helper'

# module ApplicationCable
#   class Channel < ActionCable::Channel::Base
#   end
# end

RSpec.describe ApplicationCable::Channel, type: :channel do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "mogemoge" do
    expect(3).to eq 3
  end
end
