class ItemsController < ApplicationController
  before_action :move_to_Log_in, except:[:show]
  before_action :set_item, only:[:purchase,:pay,:show]

  def index
  end

  def purchase
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
      render :purchase
    # もしcardがない場合
    else
      # indexのviewファイルを表示させる
      redirect_to credit_cards_path
    end
  end

  def pay
    credit_card = CreditCard.find_by(user_id: current_user.id)
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_ACCESS_KEY)
    charge = Payjp::Charge.create(
      amount: @item.price,
      card: credit_card.card_id,
      customer: credit_card.customer_id,
      currency: 'jpy'
    )
    redirect_to done_items_path
  end

  def done
  end

  def show

  end

  private
  def set_item
    @item = Item.find(params[:id])
  end
end
