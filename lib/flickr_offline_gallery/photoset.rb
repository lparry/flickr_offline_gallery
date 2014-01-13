module FlickrOfflineGallery
  class Photoset

    include VerbosePuts

    def initialize(photoset_id, args = {})
      @photoset_id = photoset_id
      @output_base_path = args[:output_path] || "."
      eager_load
    end

    def username
      info.ownername
    end

    def title
      info.title
    end

    def slug
      title.downcase.tr_s("^a-z0-9", "-")
    end

    def photos
      raise "photoset has more than 500 images and I'm too lazy to handle that right now" if info.pages > 1
     verbose_puts "Initializing photoset... " unless @photos
      @photos ||= info.photo.map do |raw_response|
        Photo.new(raw_response,
                  :photoset_id => @photoset_id,
                  :path_manager => path_manager)
      end.tap{ verbose_puts "Finished initializing photoset!" }
    end

    def index_page_filename
      path_manager.index_page
    end

    private

    def path_manager
      PathManager.new(@output_base_path, slug)
    end

    def eager_load
      info
      photos
    end

    def info
      @info ||= OpenStruct.new(FlickrAPI.get_photoset(@photoset_id))
    end
  end
end
