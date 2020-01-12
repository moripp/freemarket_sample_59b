class CreateCreditCards < ActiveRecord::Migration[5.2]
  def change
    create_table :credit_cards do |t|
      # user_id     → Userテーブルのidを外部キー制約で関連付け
      t.references :user,        null: false, foreign_key: true 
      # customer_id → payjpの顧客id
      t.string     :customer_id, null: false
      # card_id     → payjpのデフォルトカードid
      t.string     :card_id,     null: false
      t.timestamps
    end
  end
end
