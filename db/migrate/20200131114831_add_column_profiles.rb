class AddColumnProfiles < ActiveRecord::Migration[5.2]
  def change
    add_column :profiles, :user_id, :integer, unique: true  
  end
end
