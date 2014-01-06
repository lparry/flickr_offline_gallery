module FlickrOfflineGallery
  class Photoset
    def initialize(photoset_id)
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
      title.downcase.gsub(/[^a-z0-9]/, "-").gsub(/-+/, "-")
    end

    def photos
      raise "photoset has more than 500 images and I'm too lazy to handle that right now" if info.pages > 1
      puts "Initializing photoset... " unless @photos
      @photos ||= info.photo.map { |raw_response| Photo.new(raw_response, @photoset_id) }.tap{ puts "Finished initializing photoset!"}
    end

    private

    def info
      @info ||= OpenStruct.new(FlickrAPI.get_photoset(@photoset_id))
    end
  end
end
