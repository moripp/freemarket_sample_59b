class HomeController < ApplicationController
  

  def index
   
    @item = Item.all.order(id: "DESC").limit(10)
  
  end
end
