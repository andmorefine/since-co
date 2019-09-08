class AddColumnProverbSynonym < ActiveRecord::Migration[5.2]
  def change
    add_column :proverb_synonyms, :delete_flag, :boolean, default: 0, after: :proverb_id
  end
end
