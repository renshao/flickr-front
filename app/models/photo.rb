class Photo < OpenStruct  

  def initialize(attributes)
    super(attributes.slice :id, :owner, :secret, :server, :farm, :title,
                           :ispublic, :isfriend, :isfamily)
  end

  def large_square_url
    "https://farm#{farm}.staticflickr.com/#{server}/#{id}_#{secret}_q.jpg"
  end

end