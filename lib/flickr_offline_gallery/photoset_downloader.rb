require 'net/http'
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
          download_file(url, local_path)
         ::FlickrOfflineGallery.verbose_puts "Downloaded #{local_path}"
        end
      end
    end

    private

    def photos
      @photoset.photos
    end

    def download_file(url, destination)
      uri = URI.parse(url)
      Net::HTTP.start(uri.host,uri.port) do |http|
        resp = http.get(uri.path)
        File.open(destination, "wb") do |file|
          file.write(resp.body)
        end
      end
    end

  end
end
