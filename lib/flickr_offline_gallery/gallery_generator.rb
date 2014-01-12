module FlickrOfflineGallery

  class GalleryGenerator

    def initialize(photoset)
      @photoset = photoset
    end

    def render_photoset(size)
      download_images(size)
      render_photo_pages
      PhotosetIndexPage.new(@photoset).write
    end

    def download_images(size = "medium_800")
      PhotosetDownloader.new(@photoset, size).download
    end

    def render_photo_pages
      @photoset.photos.each do |photo|
        PhotoPage.new(photo).write
      end
    end
  end

end
