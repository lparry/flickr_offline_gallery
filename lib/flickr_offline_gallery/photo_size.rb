module FlickrOfflineGallery
  class PhotoSize

    attr_reader :label, :width, :height, :source

    def initialize(flickraw_response)
      @label  = flickraw_response.label
      @height = flickraw_response.height
      @width  = flickraw_response.width
      @source = flickraw_response.source
    end

    def key
      label.downcase.gsub(" ", "_")
    end
  end
end
