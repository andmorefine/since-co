require 'rails_helper'

RSpec.describe User, type: :model do

  it "名前が登録できること" do
    user = User.new(name: "侍")
    expect(user.name).to eq "侍"
  end

end
