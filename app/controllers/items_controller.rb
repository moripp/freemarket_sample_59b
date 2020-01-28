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

  def show
    @item = Item.find(params[:id])

  end

  def destroy
    @item = Item.find(params[:id])
      if @item.user_id == current_user.id
        @item.destroy
      end
  end

  private
  def item_params
    params.require(:item)
          .permit(:name, :description, :price, images_attributes: [:image])
          .merge(user_id: current_user.id) #paramsハッシュにuser_id追加
  end

end
