class Proverb < ApplicationRecord
  # belongs_to :m_alphabetal, foreign_key: 'id', primary_key: 'alphabetal_id'
  enum delete_flag: { draft: 0, published: 1 }

  def published
    return if self.delete_flag?
    update({delete_flag: Proverb.delete_flags['published'], alphabetal_id: Time.current})
  end

end
