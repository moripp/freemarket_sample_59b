class Item < ApplicationRecord
  has_many :images
  accepts_nested_attributes_for :images # 商品の情報と一緒に画像も保存されるようにする
end
