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
         validates :postal_code, presence: true
         validates :prefectures, presence: true
         validates :city, presence: true
         validates :address, presence: true
         validates :tel, presence: true

end
