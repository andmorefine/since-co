# frozen_string_literal: true

class AddColumnProverb < ActiveRecord::Migration[5.2]
  def change
    add_column :proverbs, :order, :integer, default: 0, after: :image
  end
end
