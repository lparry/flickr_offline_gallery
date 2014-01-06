module FlickrOfflineGallery
  class PhotoSize

    attr_reader :label, :width, :height, :source

    def initialize(horrible_flickraw_response_junk)
      @label  = horrible_flickraw_response_junk.label
      @height = horrible_flickraw_response_junk.height
      @width  = horrible_flickraw_response_junk.width
      @source = horrible_flickraw_response_junk.source
    end

    def key
      label.downcase.gsub(" ", "_")
    end
  end
end
