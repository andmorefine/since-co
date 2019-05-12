# frozen_string_literal: true

class MAlphabetal < ApplicationRecord
  has_many :proverb, foreign_key: 'alphabetal_id'
end
