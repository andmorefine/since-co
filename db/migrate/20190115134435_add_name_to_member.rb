class AddNameToMember < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :name, :string
  end
end
