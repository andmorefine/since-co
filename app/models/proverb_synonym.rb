class ProverbSynonym < ApplicationRecord
  belongs_to :proverb

  scope :active, -> { where(delete_flag: false) }

end
