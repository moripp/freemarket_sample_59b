class CreditCardsController < ApplicationController
  require "payjp"
  # before_action :set_card

  def index
    card = current_user.credit_card
    if card.blank?
      render :new
    else
      render :create
    end
  end

  def new
    Payjp.api_key = 'sk_test_09088df6ac5f5a56b2df8d37'

    if params['payjp-token'].blank?
      # paramsの中にjsで作った'payjpTokenが存在するか確かめる。トークンがブランクなら、newアクションに飛ばす。
      redirect_to action: "new"
    else
      # トークンが正常に発行されていたら、顧客情報をPAY.JPに登録する
      customer = Payjp::Customer.create(
        email: current_user.email,
        card: params['payjp-token'],
      )
      @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "index"
      else
        redirect_to action: "create"
      end
    end
  end

  def create
    card = current_user.credit_card
    if card.blank?
      redirect_to action: "new" 
    else
      Payjp.api_key = "sk_test_09088df6ac5f5a56b2df8d37"
      customer = Payjp::Customer.retrieve(card.customer_id)
      @customer_card = customer.cards.retrieve(card.card_id)
    end
end

  # private

  # def set_card
  #   @card = CreditCard.where(user_id: current_user.id).first if CreditCard.where(user_id: current_user.id).present?
  # end
end
