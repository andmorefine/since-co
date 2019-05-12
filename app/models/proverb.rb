# frozen_string_literal: true

class Proverb < ApplicationRecord
  belongs_to :m_alphabetal, primary_key: 'alphabetal_id', optional: true
  # enum delete_flag: { draft: 0, published: 1 }
  scope :active, -> { where(delete_flag: false) }
  scope :image_active, -> { where.not(image: '') }
  scope :recent, -> { order(id: :desc) }

  has_paper_trail skip: %i[updated_at image], on: [:update]
  # def published
  #   return if self.delete_flag?
  #   update({delete_flag: Proverb.delete_flags['published'], alphabetal_id: Time.current})
  # end
end
