class ItemsController < ApplicationController
  before_action :move_to_Log_in
  before_action :set_item, only:[:purchase,:pay,:show,:show_myitem,:destroy,:edit]

  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      render :create
    else
      render :new
    end
  end


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

  def destroy
    if  @item.user_id == current_user.id && @item.destroy
      redirect_to mypages_path
    else
      render :index
    end
  end

  def show_myitem
  end

  def edit
  end

  def update
  end


  private
  def item_params
    params.require(:item)
          .permit(:name, :description, :price, images_attributes: [:image])
          .merge(user_id: current_user.id) #paramsハッシュにuser_id追加
  end

  def set_item
    @item = Item.find(params[:id])
  end

end
