# frozen_string_literal: true

class CreateContacts < ActiveRecord::Migration[5.2]
  def change
    create_table :contacts do |t|
      t.string :name
      t.string :email
      t.string :phone_number
      t.string :subject
      t.text :body
      t.integer :category_id, null: false, default: 0

      t.timestamps
    end
  end
end
