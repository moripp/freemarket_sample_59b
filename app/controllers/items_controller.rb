class ItemsController < ApplicationController
  before_action :move_to_Log_in

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

  def pay
    @item = Item.find(params[:id])
    # Payjp.api_key = ENV['PAYJP_PRIVATE_KEY']
    # charge = Payjp::Charge.create(
    # amount: @item.price,
    # card: params['payjp-token'],
    # currency: 'jpy'
    # )
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
  end


  private
  def item_params
    params.require(:item)
          .permit(:name, :description, :price, images_attributes: [:image])
          .merge(user_id: current_user.id) #paramsハッシュにuser_id追加
  end

end
