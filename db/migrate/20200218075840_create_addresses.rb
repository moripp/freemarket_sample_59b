class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.string :name_sei
      t.string :name_mei
      t.string :kana_sei
      t.string :kana_mei
      t.string :postal_code
      t.string :prefectures
      t.string :city
      t.string :address
      t.string :building
      t.string :tel
      t.references :user

      t.timestamps
    end
  end
end
