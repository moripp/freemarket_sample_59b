class MyitemsController < ApplicationController
  before_action :move_to_Log_in
  before_action :check_item_owner

  def show
  end

  def edit
    gon.item = @item # gemのgonを使って@itemの情報をjsに渡す
    gon.item_images = @item.images
    @item.images.new
  end

  def update
    ActiveRecord::Base.transaction do # トランザクションを定義して下記①〜③の工程をまとめる
      # 3つの機能で構成
      # ①必要なら保存済みの画像を削除（formから受け取るdelete_image_idsを使って削除）
      # ②更新（追加画像があればcreateし、その他nameやpriceなど変更があればupdate）
      # ③画像が0枚になってないか確認
      delete_images = Image.where(id: item_images_delete_params, item_id: params[:id]) # 悪意のあるform情報から守る為、whereにitem_idの条件追加
      delete_images.destroy_all # ①画像削除
      @item.update!(item_edit_params) # ②更新
      # ③画像が0枚になっていないか確認
      item_images = Item.find(params[:id]).images.length # ①②を終えた後の画像の枚数取得（普通は1〜10になる）
      item_images / item_images # 普通は1になるが、画像0枚の時だけ例外処理が発生し、トランザクションで弾かれる
    end
      redirect_to action: 'show' # 成功したらshowへ
    rescue
      redirect_to action: 'edit' # ①〜③どれか失敗したら変更を取り消してeditへ戻る
  end

  def destroy
    if @item.destroy
      redirect_to mypages_path
    else
      render :show
    end
  end

  private
  def check_item_owner # itemの出品者とログインユーザーが一致しているか確認
    @item = Item.find(params[:id])
    unless @item.user_id == current_user.id
      redirect_to root_path
    end
  end

  def item_images_delete_params # 削除が必要なimage_idを取り出す
    params.fetch(:delete_image_ids, {}) # 空の場合エラーにならないようfetch使用
  end

  def item_edit_params
    params.require(:item)
          .permit(:name, :description, :price, images_attributes: [:image])
  end
end
