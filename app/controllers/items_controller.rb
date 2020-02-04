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

  def edit
    @item = Item.find(params[:id])
    gon.item = @item # gemのgonを使って@itemの情報をjsに渡す
    gon.item_images = @item.images
    @item.images.new
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
