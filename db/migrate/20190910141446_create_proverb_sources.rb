class CreateProverbSources < ActiveRecord::Migration[5.2]
  def change
    create_table :proverb_sources do |t|
      t.string :title
      t.boolean :delete_flag, default: 0
      t.references :proverb, foreign_key: true

      t.timestamps
    end
  end
end
