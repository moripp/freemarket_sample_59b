class Item < ApplicationRecord
  belongs_to :user
  has_many :images , dependent: :destroy
  accepts_nested_attributes_for :images # 商品の情報と一緒に画像も保存されるようにする

  enum status: {for_sale: 0, not_sale: 1}

  validates :images, associated: true
  validates :name, presence: true, length: { maximum: 40 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999}
end
