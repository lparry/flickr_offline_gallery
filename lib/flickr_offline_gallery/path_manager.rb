module FlickrOfflineGallery
  class PathManager

    attr_reader :base_path

    def initialize(base_path, slug)
      @base_path = base_path
      @slug     = slug
    end

    def photo_output_path
      File.join(base_path, @slug)
    end

    def index_page
      "#{photo_output_path}.html"
    end

    def full_path_for(photo_id, extension)
      File.join(photo_output_path, filename_for_photo(photo_id, extension))
    end

    def relative_path_for(photo_id, extension)
      File.join(@slug, filename_for_photo(photo_id, extension))
    end

    def filename_for_photo(photo_id, extension)
      "#{photo_id}.#{extension}"
    end

    def back_to_index
      "../#{@slug}.html"
    end

  end

end
