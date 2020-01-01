class Item < ApplicationRecord
  has_many :images  
  accepts_nested_attributes_for :images # 商品の情報と一緒に画像も保存されるようにする
  validates :images, associated: true

  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}
end
