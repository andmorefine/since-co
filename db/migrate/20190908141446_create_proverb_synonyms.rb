class CreateProverbSynonyms < ActiveRecord::Migration[5.2]
  def change
    create_table :proverb_synonyms do |t|
      t.string :title
      t.integer :proverb_synonym_id
      t.references :proverb, foreign_key: true

      t.timestamps
    end
  end
end
