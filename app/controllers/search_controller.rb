class SearchController < ApplicationController
  # caches search requests. Avoid hitting Flickr API unnecessary for better response time
  # and user experience
  caches_action :search, :expires_in => 5.minutes, :cache_path => Proc.new {search_path params}

  def index
  end

  def search
    @query = search_params[:text]
    results = Flickr.search(search_params)
    @current_page = results[:page].to_i
    @pages = results[:pages].to_i
    @photos = results[:photos]

    if @photos.size > 0
      render 'has_results'
    else
      render 'no_results'
    end

  end

  private

  def search_params
    params.require(:search).permit(:text, :page)
  end
end
