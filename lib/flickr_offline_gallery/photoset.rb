module FlickrOfflineGallery
  class Photoset
    def initialize(photoset_id)
      eager_load
      @photoset_id = photoset_id
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
