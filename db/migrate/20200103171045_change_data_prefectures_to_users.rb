class ChangeDataPrefecturesToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column :users, :prefectures, :integer, default: 0, null: false
  end
end
