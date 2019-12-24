class ItemsController < ApplicationController
  def new
    @item = Item.new
    @item.images.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      # 保存失敗時は失敗画面を出す
    end
  end

  private
  def item_params
    params.require(:item).permit(:name, :description, :price, images_attributes: [:image])
  end

end
