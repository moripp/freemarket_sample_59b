class ItemsController < ApplicationController
  before_action :move_to_Log_in
  before_action :set_item, only:[:pay,:show,:show_myitem,:destroy,:edit]

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
  end

  def pay
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_ACCESS_KEY)
    charge = Payjp::Charge.create(
      amount: @item.price,
      card: params['payjp-token'],
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
