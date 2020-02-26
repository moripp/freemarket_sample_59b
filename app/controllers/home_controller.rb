class HomeController < ApplicationController
  

  def index
   
    @items =Item.includes(:images).order(id: "DESC").page(params[:page]).per(20)
  
  end
end
