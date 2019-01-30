require 'rails_helper'

# module ApplicationCable
#   class Connection < ActionCable::Connection::Base
#   end
# end

RSpec.describe ApplicationCable::Connection, type: :channel do
  # pending "add some examples to (or delete) #{__FILE__}"
  it "mogemoge" do
    expect(3).to eq 3
  end
end
