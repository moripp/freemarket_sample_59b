class ItemsController < ApplicationController
  def new
    @item = Item.new
    @item.images.new
  end

  def create
    Item.create(item_params)
    redirect_to root_path
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :price, images_attributes: [:image])
  end

end
