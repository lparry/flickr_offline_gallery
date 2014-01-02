module FlickrOfflineGallery
  class PhotosetDownloader
    def initialize(photoset, size = "medium_800")
      @photoset = photoset
      @size = size
    end

    def download
      photos.each do |photo|
        url = photo.sizes[@size].source
        local_path = "#{@photoset.slug}/#{photo.id}.jpg"

        unless File.exist?(local_path)
          #TODO: this is lazy, so sue me
          `curl -so "#{local_path}" "#{url}"`
        end
      end
    end

    private

    def photos
      @photoset.photos
    end

  end
end
