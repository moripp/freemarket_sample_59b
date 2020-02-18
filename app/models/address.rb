class Address < ApplicationRecord
  belongs_to :user, optional: true

  validates :name_sei, :name_mei, :kana_sei, :kana_mei, :postal_code, :prefectures, :city, :address, presence: true
  validates :kana_sei, :kana_mei, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/} # カタカナのみ許容する
end
