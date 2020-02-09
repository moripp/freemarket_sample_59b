class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise  :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable,
          :omniauthable, omniauth_providers: [:facebook, :google_oauth2] # omniauthを使う為にオプション追記

  # associations
  has_many :items
  has_one :profile
  has_one :credit_card # ユーザーは1枚のカードのみ登録できる
  has_many :sns_credentials

  # validations
  validates :name_sei, presence: true
  validates :name_mei, presence: true
  validates :kana_sei, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/} # カタカナのみ許容する
  validates :kana_mei, presence: true, format: { with: /\A[\p{katakana}\p{blank}ー－]+\z/} # カタカナのみ許容する
  validates :birth_date, presence: true
  validates :postal_code, presence: true
  validates :prefectures, presence: true
  validates :city, presence: true
  validates :address, presence: true
  validates :tel, presence: true

  def self.from_omniauth(auth)
    # 次の2行で3パターンの動きをしている
    # ①SNS認証したことがあればアソシエーションでuser情報取得
    # ②SNS認証したこと無ければ、emailアドレスで検索してuser情報取得
    # ③SNS認証したことが無く、emailアドレス検索でもuser情報が見つからない場合、新しくuserのレコードを作成する準備
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create # 条件に合うレコード取得、なければcreate
    user = sns.user || User.where(email: auth.info.email).first_or_initialize( # 条件に合うレコード取得、なければnew（まだ保存はしない）
      # user新規登録formに名前とメールアドレスを渡す準備
      name_sei: auth.info.last_name,
      name_mei: auth.info.first_name,
      email: auth.info.email
    )
    if user.persisted? # ②のようにSNS認証はしたこと無いが、user情報が存在する場合
      sns.user = user
      sns.save # SnsCredentialのuser_idを更新
    end
    { user: user, sns: sns }
  end
end
