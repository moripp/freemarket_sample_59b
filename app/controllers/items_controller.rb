class ItemsController < ApplicationController
  before_action :move_to_Log_in, except:[:show]
  before_action :set_item, only:[:pay,:show]

  def index
  end

  def purchase
    
  end

  def pay
    Payjp.api_key = Rails.application.credentials.dig(:payjp, :PAYJP_ACCESS_KEY)
    charge = Payjp::Charge.create(
      amount: @item.price,
      card: params['payjp-token'],
      currency: 'jpy'
    )
    redirect_to done_items_path
  end

  def done
  end

  def show

  end

  private
  def set_item
    @item = Item.find(params[:id])
  end
end
