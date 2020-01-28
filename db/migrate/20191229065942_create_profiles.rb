class CreateProfiles < ActiveRecord::Migration[5.2]
  def change
    create_table :profiles do |t|
      t.string       :nickname
      t.text         :introduction
      t.timestamps
    end
  end
end
