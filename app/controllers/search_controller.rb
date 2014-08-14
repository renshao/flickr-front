class SearchController < ApplicationController
  # caches search requests. Avoid hitting Flickr API unnecessary for better response time
  # and user experience
  caches_action :search, :expires_in => 5.minutes, :cache_path => Proc.new {search_path params}

  before_filter :validate_search_query, :only => :search

  def index
  end

  def search
    @query = search_params[:text]
    results = Flickr.search(search_params)
    @pagination_info = results[:pagination_info]
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

  def validate_search_query
    if search_params[:text].blank?
      flash[:notice] = "You have entered an empty query, please type in something."
      render 'no_results'
    end
  end
end
