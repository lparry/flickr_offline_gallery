module FlickrOfflineGallery
  class PhotoPage < TemplateRenderer

    def initialize(photo)
      @photo = photo
      super("photo")
    end

    def render
      render_erb(:index_page => @photo.local_html_path.sub(/\/.*/, ".html"),
            :source => @photo.img_filename,
            :sizes => @photo.sizes,
            :photo_url => @photo.url,
            :title => @photo.title,
            :author => @photo.author)
    end

    def write
      write_file(@photo.local_html_path)
    end

  end
end
