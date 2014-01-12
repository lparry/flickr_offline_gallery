module FlickrOfflineGallery
  class Photoset
    def initialize(photoset_id)
      @photoset_id = photoset_id
      eager_load
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
      @photos ||= info.photo.map do |raw_response|
        Photo.new(raw_response,
                  :photoset_id => @photoset_id,
                  :output_directory => photo_output_path)
      end.tap{::FlickrOfflineGallery.verbose_puts "Finished initializing photoset!"}
    end

    def index_page_filename
      "#{photo_output_path}.html"
    end

    def photo_output_path
      if Variables.output_directory
        File.join(Variables.output_directory, slug)
      else
        slug
      end
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
