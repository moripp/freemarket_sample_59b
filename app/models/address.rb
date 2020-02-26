class Address < ApplicationRecord
  belongs_to :user, optional: true

  validates :name_sei, :name_mei, :kana_sei, :kana_mei, :postal_code, :prefectures, :city, :address, presence: true
  validates :kana_sei, :kana_mei, format: { with: /[\p{katakana}ー－&&[^ -~｡-ﾟ]]+/ } # 全角カタカナのみ許容する
  validates :postal_code, format: { with: /\A\d{3}[-]\d{4}$|^\d{3}[-]\d{2}$|^\d{3}$|^\d{5}$|^\d{7}\z/ } # 郵便番号形式のみ許容する
end
