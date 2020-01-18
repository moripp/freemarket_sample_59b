class CreditCardsController < ApplicationController
  require "payjp"
  # before_action :set_card

  def new # カードの登録画面。送信ボタンを押すとcreateアクションへ。
    card = CreditCard.where(user: current_user).first
    # redirect_to action: :index if CreditCard.present?
  end

  def index
  end

  def create
    Payjp.api_key = 'sk_test_09088df6ac5f5a56b2df8d37'

    if params['payjp-token'].blank?
      # トークンがブランクなら、newアクションに飛ばす。
      redirect_to action: "new"
    else
      # トークンが正常に発行されていたら、顧客情報をPAY.JPに登録する
      customer = Payjp::Customer.create(
        email: current_user.email,
        card: params['payjp-token'],
      )
      @card = Card.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "index"
      else
        redirect_to action: "create"
      end
    end
  end

  # private

  # def set_card
  #   @card = CreditCard.where(user_id: current_user.id).first if CreditCard.where(user_id: current_user.id).present?
  # end
end
