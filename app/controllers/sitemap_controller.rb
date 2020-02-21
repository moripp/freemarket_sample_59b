class SitemapController < ApplicationController
  def index
    @items = Item.all
    @users = User.all
    @profiles = Profile.all
    @images = Image.all
  end
end
