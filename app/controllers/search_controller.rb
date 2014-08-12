class SearchController < ApplicationController
  def index
  end

  def search
    @photos = Flickr.search params
  end
end
