class HomeController < ApplicationController
  

  def index
   
    @item = Item.order(id: "DESC").limit(10)
  
  end
end
