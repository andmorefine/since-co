class Count < ApplicationRecord
  scope :twitter, -> { find_by(service_name: "twitter") }

  def initialize
    self.count = 0.to_f
  end

  def count_up(num)
    self.count += num.to_i
  end
end
