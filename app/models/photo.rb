class Photo < OpenStruct  

  def initialize(attributes)
    super(attributes.slice :id, :owner, :secret, :server, :farm, :title,
                           :ispublic, :isfriend, :isfamily)
  end

  def thumbnail_url
    "https://farm#{farm}.staticflickr.com/#{server}/#{id}_#{secret}_q.jpg"
  end

  def large_url
    "https://farm#{farm}.staticflickr.com/#{server}/#{id}_#{secret}_c.jpg"
  end

end