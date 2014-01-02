module FlickrOfflineGallery
  class PhotoSize < OpenStruct
    # attrs: label, width, height, source
    def initialize(horrible_flickraw_response_junk)
      super(horrible_flickraw_response_junk.to_hash)
    end
  end
end
