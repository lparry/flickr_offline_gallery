module FlickrOfflineGallery
  class PhotoPage < TemplateRenderer

    def initialize(photo)
      @photo = photo
      super("photo")
    end

    def render
      render_erb(:back_to_index_page => @photo.back_to_index_url,
            :image_url => @photo.img_filename,
            :sizes => @photo.sizes,
            :photo_page_url => @photo.url,
            :title => @photo.title,
            :author => @photo.author)
    end

    def write
      write_file(@photo.full_html_path)
    end

  end
end
