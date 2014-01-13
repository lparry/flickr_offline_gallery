require 'httparty'
module FlickrOfflineGallery
  class PhotosetDownloader

    include VerbosePuts

    def initialize(photoset, size)
      @photoset = photoset
      @size = size
    end

    def download
      photos.each do |photo|
        url = photo.sizes[@size].url
        local_path = photo.full_jpg_path
        FileUtils.mkdir_p(File.dirname(local_path))

        unless File.exist?(local_path)
          download_file(url, local_path)
         verbose_puts "Downloaded #{local_path}"
        end
      end
    end

    private

    def photos
      @photoset.photos
    end

    def download_file(url, destination)
      resp = http_get(url)
      File.open(destination, "wb") do |file|
        file.write(resp.body)
      end
    end

    def http_get(url)
      response = HTTParty.get(url)
      raise "unhandled response code: #{response.code}" unless response.code == 200
      response
    end

  end
end
