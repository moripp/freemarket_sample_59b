class RemoveNameFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :postal_code
    remove_column :users, :prefectures
    remove_column :users, :city
    remove_column :users, :address
    remove_column :users, :building
    remove_column :users, :tel
  end
end
