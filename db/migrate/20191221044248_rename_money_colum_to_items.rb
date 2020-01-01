class RenameMoneyColumToItems < ActiveRecord::Migration[5.2]
  def change
    rename_column :items, :money, :price
  end
end
