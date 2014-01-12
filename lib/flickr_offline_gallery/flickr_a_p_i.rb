module FlickrOfflineGallery
  class FlickrAPI
    def self.instance
      @instance ||= FlickRaw::Flickr.new
    end

    def self.get_photoset(photoset_id)
      instance.photosets.getPhotos(:photoset_id => photoset_id).to_hash
    end

    def self.get_photo_info(photo_id)
      instance.photos.getInfo(:photo_id => photo_id).to_hash
    end

    def self.get_photo_sizes(photo_id)
      instance.photos.getSizes(:photo_id => photo_id).to_a
    end

  end
end

# No thanks Flickraw. Not even once.
undef flickr
