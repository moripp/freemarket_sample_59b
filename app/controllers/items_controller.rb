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

  private
  def item_params
    params.require(:item)
          .permit(:name, :description, :price, images_attributes: [:image])
          .merge(user_id: current_user.id) #paramsハッシュにuser_id追加
  end

  def move_to_Log_in #サインインしてない時はログイン画面へ
    redirect_to new_user_session_path unless user_signed_in?
  end

end
