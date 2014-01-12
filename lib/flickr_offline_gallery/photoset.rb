module FlickrOfflineGallery
  class Photoset
    def initialize(photoset_id)
      @photoset_id = photoset_id
      eager_load
      ::FlickrOfflineGallery::Variables.slug = slug
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
     ::FlickrOfflineGallery.verbose_puts "Initializing photoset... " unless @photos
      @photos ||= info.photo.map { |raw_response| Photo.new(raw_response, @photoset_id) }.tap{::FlickrOfflineGallery.verbose_puts "Finished initializing photoset!"}
    end

    def index_page_filename
      if ::FlickrOfflineGallery::Variables.output_directory
        "#{::FlickrOfflineGallery::Variables.output_directory}/#{slug}.html"
      else
        "#{slug}.html"
      end
    end

    private

    def eager_load
      info
      photos
    end

    def info
      @info ||= OpenStruct.new(FlickrAPI.get_photoset(@photoset_id))
    end
  end
end
