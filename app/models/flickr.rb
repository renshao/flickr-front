require 'open-uri'

class Flickr
  FLICKR_API_URL = 'https://api.flickr.com/services/rest'

  def self.search(params)
    json = self.call_api(self.build_search_url params)
    result_hash = HashWithIndifferentAccess.new(JSON.parse json)[:photos]
    
    photos = result_hash[:photo].map { |attributes| Photo.new(attributes) }

    result_hash.slice(:page, :pages, :perpage, :total).merge(photos: photos)
  end

  def self.default_params
    {
      method: 'flickr.photos.search',
      api_key: ENV['FLICKR_API_KEY'],
      format: 'json',
      nojsoncallback: 1,
      per_page: 24
    }
  end

  def self.build_search_url(params)
    query_string = params.merge(self.default_params).to_param

    url = "#{FLICKR_API_URL}?#{query_string}"
  end

  private

  def self.call_api(url)
    open(url).read
    # File.open('/Users/ren/Desktop/flickr-sample.json', "r").read
  end
end