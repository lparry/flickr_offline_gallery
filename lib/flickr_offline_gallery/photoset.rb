module FlickrOfflineGallery
  class Photoset
    def initialize(photoset_id)
      @photoset_id = photoset_id
      ::FlickrOfflineGallery::Variables.slug = slug
    end

    def username
      info.username
    end

    def title
      info.title
    end

    def slug
      title.downcase.gsub(/[^a-z0-9]/, "-")
    end

    def photos
      raise "photoset has more than 500 images and I'm too lazy to handle that right now" if info.pages > 1
      @photos ||= info.photo.map { |raw_response| Photo.new(raw_response, @photoset_id) }
    end

    private

    def info
      @info ||= OpenStruct.new(flickr.photosets.getPhotos(:photoset_id => @photoset_id).to_hash)
    end
  end
end
