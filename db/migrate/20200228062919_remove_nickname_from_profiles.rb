class RemoveNicknameFromProfiles < ActiveRecord::Migration[5.2]
  def change
    remove_column :profiles, :nickname, :string
  end
end
