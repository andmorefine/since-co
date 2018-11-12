class CreateProverbs < ActiveRecord::Migration[5.2]
  def change
    create_table :proverbs do |t|
      t.string :name
      t.string :kana
      t.text :text
      t.string :image
      t.integer :alphabetal_id, null:false, default: 0
      t.boolean :delete_flag, default: false

      t.timestamps
    end
  end
end
