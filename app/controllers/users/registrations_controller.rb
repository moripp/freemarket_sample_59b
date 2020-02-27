class Users::RegistrationsController < Devise::RegistrationsController
  before_action :configure_params_if_authentication_sns, only: [:create]

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(sign_up_params)
    unless @user.valid? # バリデーション確認
      flash.now[:alert] = @user.errors.full_messages
      render :new and return
    end
    session["devise.regist_data"] = {user: @user.attributes} # セッションに格納
    session["devise.regist_data"][:user]["password"] = params[:user][:password] # passwordだけ入らないのでやり直し
    @address = @user.build_address
    render :new_address # セッションに保存したまま次の画面へ
  end

  def create_address
    @user = User.new(session["devise.regist_data"]["user"]) # セッションの情報からuserのインスタンス作成
    @address = Address.new(address_params) # formの情報からaddressのインスタンス作成
    unless @address.valid? # バリデーション確認
      flash.now[:alert] = @address.errors.full_messages
      render :new_address and return
    end

    session["devise.regist_data"][:address] = @address.attributes # address情報をセッションに格納
    render :new_credit_card
  end

  def create_credit_card
    # まずはuserとaddressのインスタンス準備
    @user = User.new(session["devise.regist_data"]["user"]) # userのインスタンス作成
    @address = session["devise.regist_data"]["address"] # address情報取り出し
    @user.build_address(@address) # addressのインスタンス作成

    # ここからcredit_card登録作業（credit_cardコントローラーの内容をほぼコピー）
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_ACCESS_KEY)
    if params['payjp-token'].blank?
      render :new_credit_card
    else
      customer = Payjp::Customer.create(card: payjp_token_params[params['payjp-token']])
      @user.build_credit_card(customer_id: customer.id, card_id: customer.cards.data[0].id)      
    end
  end

  private
  def configure_params_if_authentication_sns
    # SNS認証してから新規登録をした場合は、パスワードを自動生成してparamsに入れる
    if params[:sns_auth] == 'true'
      pass = Devise.friendly_token # パスワードを自動生成
      params[:user][:password] = pass
      params[:user][:password_confirmation] = pass
    end
  end

  def address_params
    params.require(:address)
          .permit(:name_sei, :name_mei, :kana_sei, :kana_mei,
                  :postal_code, :prefectures, :city, :address, :building,
                  :tel)
  end

  def payjp_token_params
    params.require(:"payjp-token")
  end
end
