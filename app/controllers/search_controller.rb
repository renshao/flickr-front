class SearchController < ApplicationController
  def index
  end

  def search
    @photos = Flickr.search(search_params)[:photos]
  end

  private

  def search_params
    params.require(:search).permit(:text, :page, :per_page)
  end
end
