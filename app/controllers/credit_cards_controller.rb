class CreditCardsController < ApplicationController
  
  require "payjp"
  before_action :move_to_Log_in
  
  def index
    # payjpテスト秘密鍵をセット
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_ACCESS_KEY)
    # 今ログインしているユーザーのクレジットカードを@cardに代入
    @card = current_user.credit_card
    # もしcardがある場合
    if @card
      # @cardから顧客情報(customer_id)を取得し customerに代入
      customer = Payjp::Customer.retrieve(@card.customer_id) 
      # customerからcard_idを取得し @customer_card に代入
      @customer_card = customer.cards.retrieve(@card.card_id) 
      # index_createdのviewファイルを表示させる
      render :index_created
    # もしcardがない場合
    else
      # indexのviewファイルを表示させる
      render :index
    end
  end
  
  # クレジットカード登録フォーム
  def new
    
  end

  def create
    # payjpテスト秘密鍵をセット
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_ACCESS_KEY)
    # paramsの中にjsで作った'payjp-Tokenが存在するか確かめる。まだ存在しない場合、
    if params['payjp-token'].blank?
      # newアクションに飛ばす。
      redirect_to action: "new"
    # payjp-tokenが存在する場合
    else
      # 顧客情報をPAY.JPに作成しcustomerに代入。その時にcardというキーに対して、payjp-tokenのparamsのvalueを入れる
      customer = Payjp::Customer.create(
        card: payjp_token_params[params['payjp-token']]
      )
      # 引数に代入されている情報を元にクレジットカードの新しいインスタンスを作成し、@cardに代入。
      @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.cards.data[0].id)
      # もしカード情報がsaveできたら
      if @card.save
        # indexアクションに飛ばす。
        redirect_to action: "index"
      else
        # そうではない場合newアクションに飛ばす。
        redirect_to action: "new"
      end
    end
  end

  private
  
  # Strong Parameters
  def payjp_token_params
    params.require(:"payjp-token")
  end

end
