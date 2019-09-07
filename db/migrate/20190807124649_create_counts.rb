# frozen_string_literal: true

class CreateCounts < ActiveRecord::Migration[5.2]
  def change
    create_table :counts do |t|
      t.string :service_name
      t.integer :count, default: 0, null: false
      t.integer :limit, default: 0, null: false

      t.timestamps
    end
  end
end
