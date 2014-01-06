module FlickrOfflineGallery
  class PhotosetDownloader
    def initialize(photoset, size)
      @photoset = photoset
      @size = size
    end

    def download
      photos.each do |photo|
        url = photo.sizes[@size].source
        local_path = photo.local_jpg_path
        FileUtils.mkdir_p(File.dirname(local_path))

        unless File.exist?(local_path)
          #TODO: this is lazy, so sue me
          `curl --location -so "#{local_path}" "#{url}"`
         ::FlickrOfflineGallery.verbose_puts "Downloaded #{local_path}"
        end
      end
    end

    private

    def photos
      @photoset.photos
    end

  end
end
