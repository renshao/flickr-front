require 'open-uri'

class Flickr
  FLICKR_API_URL = 'https://api.flickr.com/services/rest'

  def self.search(params)
    json = self.call_api(self.build_search_url params)
    result_hash = HashWithIndifferentAccess.new(JSON.parse json)[:photos]
    photos = result_hash[:photo].map { |attributes| Photo.new(attributes) }

    # ensure all values are integers (as Flickr sometimes return string values like "7300")
    pagination_info = result_hash.slice(:page, :pages, :perpage, :total)
    pagination_info.each do |key, value|
      unless value.is_a?(Integer)
        pagination_info[key] = value.to_i
      end
    end

    {
      pagination_info: pagination_info,
      photos: photos
    }
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
  end
end