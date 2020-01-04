class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         validates :name_sei, presence: true
         validates :name_mei, presence: true
         validates :kana_sei, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/}
         # カタカナのみ許容する
         validates :kana_mei, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/}
         # カタカナのみ許容する
         validates :birth_date, presence: true
         validates :postal_code, presence: true, format: {with: /\A[0-9]{3}[0-9]{4}\z/}
         # 7桁の半角数字のみ許容（ハイフンなし）
         validates :prefectures, presence: true
         validates :city, presence: true
         validates :address, presence: true
         validates :tel, presence: true
  
  # 都道府県をプルダウンで実装するための文字列指定 [表示:DBに入る値]
  enum prefectures: {
    北海道:1,青森県:2,岩手県:3,宮城県:4,秋田県:5,山形県:6,福島県:7,
    茨城県:8,栃木県:9,群馬県:10,埼玉県:11,千葉県:12,東京都:13,神奈川県:14,
    新潟県:15,富山県:16,石川県:17,福井県:18,山梨県:19,長野県:20,
    岐阜県:21,静岡県:22,愛知県:23,三重県:24,
    滋賀県:25,京都府:26,大阪府:27,兵庫県:28,奈良県:29,和歌山県:30,
    鳥取県:31,島根県:32,岡山県:33,広島県:34,山口県:35,
    徳島県:36,香川県:37,愛媛県:38,高知県:39,
    福岡県:40,佐賀県:41,長崎県:42,熊本県:43,大分県:44,宮崎県:45,鹿児島県:46,沖縄県:47
  }

end
