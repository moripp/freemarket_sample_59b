class ItemsController < ApplicationController
  before_action :move_to_Log_in
  before_action :set_item, only:[:show,:destroy]

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

  def show
  end

  def destroy
    if  @item.user_id == current_user.id
        @item.destroy
    end
    redirect_to mypages_path
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
