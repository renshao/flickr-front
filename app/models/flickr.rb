class Flickr
  def self.search(params)
    photos = []
    20.times do
      photos << Photo.new
    end

    photos
  end
end