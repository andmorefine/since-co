class CreateMAlphabetals < ActiveRecord::Migration[5.2]
  def change
    create_table :m_alphabetals do |t|
      t.text :name

      t.timestamps
    end
  end
end
