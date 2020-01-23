class CreditCardsController < ApplicationController
  require "payjp"
  # before_action :set_card

  def index
    Payjp.api_key = "sk_test_09088df6ac5f5a56b2df8d37"
    @card = current_user.credit_card
    if @card
      customer = Payjp::Customer.retrieve(@card.customer_id) 
      @customer_card = customer.cards.retrieve(@card.card_id) 
      # binding.pry
      render :index_created
    else
      render :index
    end
  end

  def new
    
  end

  def create
    Payjp.api_key = 'sk_test_09088df6ac5f5a56b2df8d37'
    if params['payjp-token'].blank?
      # paramsの中にjsで作った'payjpTokenが存在するか確かめる。トークンがブランクなら、newアクションに飛ばす。
      redirect_to action: "new"
    else
      # トークンが正常に発行されていたら、顧客情報をPAY.JPに登録する
      customer = Payjp::Customer.create(
        card: params['payjp-token']
      )
      @card = CreditCard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.cards.data[0].id)
      if @card.save
        redirect_to action: "index"
      else
        redirect_to action: "new"
      end
    end
  end

  # private

  # def set_card
  #   @card = CreditCard.where(user_id: current_user.id).first if CreditCard.where(user_id: current_user.id).present?
  # end
end
