class ItemsController < ApplicationController
  before_action :move_to_Log_in, except:[:show]
  before_action :set_item, only:[:purchase,:pay,:show,:show_myitem,:destroy,:edit]

  def index
  end

  def purchase
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_ACCESS_KEY)
    # 今ログインしているユーザーのクレジットカードを@cardに代入
    @card = current_user.credit_card
    # もしcardがある場合
    if @card
      # @cardから顧客情報(customer_id)を取得し customerに代入
      customer = Payjp::Customer.retrieve(@card.customer_id) 
      # customerからcard_idを取得し @customer_card に代入
      @customer_card = customer.cards.retrieve(@card.card_id) 
      # index_createdのviewファイルを表示させる
      render :purchase
    # もしcardがない場合
    else
      # indexのviewファイルを表示させる
      redirect_to credit_cards_path
    end
  end

  def pay
    credit_card = CreditCard.find_by(user_id: current_user.id)
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_ACCESS_KEY)
    charge = Payjp::Charge.create(
      amount: @item.price,
      card: credit_card.card_id,
      customer: credit_card.customer_id,
      currency: 'jpy'
    )
    redirect_to done_items_path
  end

  def done
  end

  def show

  end

  def destroy
    if  @item.user_id == current_user.id && @item.destroy
      redirect_to mypages_path
    else
      render :index
    end
  end

  def show_myitem
  end

  def edit
    @item = Item.find(params[:id])
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


  private
  def item_images_delete_params # 削除が必要なimage_idを取り出す
    params.fetch(:delete_image_ids, {}) # 空の場合エラーにならないようfetch使用
  end

  def item_edit_params
    params.require(:item)
          .permit(:name, :description, :price, images_attributes: [:image])
  end

  def set_item
    @item = Item.find(params[:id])
  end
end
