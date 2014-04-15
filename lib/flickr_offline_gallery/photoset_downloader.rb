require 'httparty'
require "thread/pool"

module FlickrOfflineGallery
  class PhotosetDownloader

    include VerbosePuts

    def initialize(photoset, size)
      @photoset = photoset
      @size = size
    end

    def download
      pool = Thread.pool(ENV["FLICKR_OFFLINE_GALLERY_DOWNLOAD_THREADPOOL_SIZE"] || 4)
      photos.each do |photo|
        pool.process do
          url = photo.sizes[@size].url
          local_path = photo.full_jpg_path
          FileUtils.mkdir_p(File.dirname(local_path))

          unless File.exist?(local_path)
            download_file(url, local_path)
            verbose_puts "Downloaded #{local_path}"
          end
        end
      end
      pool.shutdown
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
