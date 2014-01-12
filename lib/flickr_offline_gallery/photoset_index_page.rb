module FlickrOfflineGallery
  class PhotosetIndexPage < TemplateRenderer

    def initialize(photoset)
      @photoset = photoset
      super("photoset")
    end

    def render
      render_erb(:photoset => @photoset, :photos => @photoset.photos, :size => "medium")
    end

    def write
      write_file("#{@photoset.slug}.html")
    end
  end
end
