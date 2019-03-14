class CreateOneHundredPeople < ActiveRecord::Migration[5.2]
  def change
    create_table :one_hundred_people do |t|
      t.string :kami
      t.string :simo
      t.string :kami_kana
      t.string :simo_kana
      t.string :author

      t.timestamps
    end
  end
end
