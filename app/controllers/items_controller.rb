class ItemsController < ApplicationController
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

  def show
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :price, images_attributes: [:image])
  end

end
