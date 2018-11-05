class AddDeletFlagToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :delete_flag, :boolean, default: 0, :after => :name
  end
end
