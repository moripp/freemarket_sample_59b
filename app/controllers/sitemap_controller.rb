class SitemapController < ApplicationController
  def index
    @item = Item.all
  end
end
