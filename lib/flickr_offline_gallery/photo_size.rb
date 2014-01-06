module FlickrOfflineGallery
  class PhotoSize < OpenStruct
    # attrs: label, width, height, source
    def initialize(horrible_flickraw_response_junk)
      super(horrible_flickraw_response_junk.to_hash)
    end

    def height
      super.to_i
    end

    def width
      super.to_i
    end

    def url
      source
    end

    def key
      label.downcase.gsub(" ", "_")
    end
  end
end
