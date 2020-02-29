class MypagesController < ApplicationController
  before_action :move_to_Log_in
  def index
  end

  def show
    @items =Item.for_sale.where(user_id: current_user.id).includes(:images).order(id: "DESC").page(params[:page]).per(10)
  end
end