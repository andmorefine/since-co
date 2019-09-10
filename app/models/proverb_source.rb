class ProverbSource < ApplicationRecord
  belongs_to :proverb

  # scope :active, -> { where(delete_flag: false) }
  scope :active, -> { where.not(title: '') }

end
