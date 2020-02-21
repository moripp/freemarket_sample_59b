class HomeController < ApplicationController
  

  def index
   
    @items = Item.includes(:images).order(id: "DESC").limit(10)
  
  end
end
