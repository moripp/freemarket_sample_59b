class HomeController < ApplicationController
  

  def index
   
    @item = Item.includes(:images).order(id: "DESC").limit(10)
  
  end
end
