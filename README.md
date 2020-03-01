
# items
|Column|Type|Options|
|------|----|-------|
|name|string|null:false|
|user_id|references|null: false, foreign_key: true|
|description|text|null: false|
|status|integre|nill:false|
|buy_id|references|foreign_key: true|
|category_id|references|foreign_key: true|

## Association
- belongs_to :user
- has_many :images
- has_one :buy
- belongs_to :category

# users
|Column|Type|Options|
|------|----|-------|
|name_sei|string|null: false|
|name_mei|string|null: false|
|kana_sei|string|null: false|
|kana_mei|string|null: false|
|birth_date|date|null: false|
|email|text|null: false, unique: true|
|password|text|null: false|
|recaptcha|text|null: false|
|postal_code|string|null: false|
|prefectures|string|null: false|
|city|string|null: false|
|address|string| null: false|
|building|string||
|tel|string|null: false|
|profile_id|references|null: false|
|credit_card_id|references|null: false|

## Association
- has_one :profile
- has_many :items
- has_many :buys
- has_one :credit_card

# buys
|Column|Type|Options|
|------|----|-------|
|item_id|references|null: false, foreign_key: true|
|user_id|references|null: false, foreign_key: true|

## Association
- belongs_to :item
- belongs_to :user

# images
|Column|Type|Options|
|------|----|-------|
|file|string|null: false|
|item_id|references|foreign_key: true|

## Association
- belongs_to :item

# categorys
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|

## Association
- has_many :items

# profiles
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|introduction|text|null: false|

## Association
- belongs_to :user

# credit_cards
|Column|Type|Options|
|------|----|-------|
|number|string|null: false|
|expiration_mm|string|null: false|
|expiration_yy|string|null: false|
|security_code|string|null: false|

## Association
- belongs_to :user
※カラム名はgem合わせ

<!-- testpirori -->