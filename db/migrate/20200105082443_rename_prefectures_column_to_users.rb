class RenamePrefecturesColumnToUsers < ActiveRecord::Migration[5.2]
  def change
    rename_column :users, :prefectures, :prefectures_id
  end
end
