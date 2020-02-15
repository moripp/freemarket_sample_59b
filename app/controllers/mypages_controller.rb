class MypagesController < ApplicationController
  def index
    @items =Item.where(user_id: current_user.id).includes(:images).order(id: "DESC").page(params[:page]).per(5)
  end
end