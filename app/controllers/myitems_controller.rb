class MyitemsController < ApplicationController
  before_action :move_to_Log_in

  def show
  end

  def edit
    gon.item = @item # gemのgonを使って@itemの情報をjsに渡す
    gon.item_images = @item.images
    @item.images.new
  end

  def update
    # 2つの機能で構成
    # ①必要なら保存済みの画像を削除（formから受け取るdelete_image_idsを使って削除）
    # ②更新（追加画像があればcreateし、その他nameやpriceなど変更があればupdate）
    delete_images = Image.where(id: item_images_delete_params, item_id: params[:id]) # 悪意のあるform情報から守る為、whereにitem_idの条件追加
    if delete_images.destroy_all # ①画像削除
      item = Item.find(params[:id])
      if item.update(item_edit_params) # ②更新
        redirect_to action: 'show' 
      else
        render :edit # 失敗したらeditへ
      end
    else
      render :edit # 失敗したらeditへ
    end
  end

  def destroy
    if @item.destroy
      redirect_to mypages_path
    else
      render :show
    end
  end

  private

  def item_images_delete_params # 削除が必要なimage_idを取り出す
    params.fetch(:delete_image_ids, {}) # 空の場合エラーにならないようfetch使用
  end

  def item_edit_params
    params.require(:item)
          .permit(:name, :description, :price, images_attributes: [:image])
  end
end
