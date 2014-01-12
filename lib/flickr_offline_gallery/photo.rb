module FlickrOfflineGallery
  class Photo

    def initialize(horrible_flickraw_response_junk, photoset_id = nil)
      @id = horrible_flickraw_response_junk["id"]
      @photoset_id = photoset_id
      eager_load
     ::FlickrOfflineGallery.verbose_puts %(Fetched data about photo #{@id}: "#{title}")
    end

    def title
      info.title
    end

    def url
      if @photoset_id
        "#{base_url}in/set-#{@photoset_id}"
      else
        base_url
      end
    end

    def img_filename
      "#{@id}.jpg"
    end

    def local_jpg_path
      "#{::FlickrOfflineGallery::Variables.slug}/#{img_filename}"
    end

    def local_html_path
      local_jpg_path.sub(/\.jpg$/, ".html")
    end

    def base_url
      @base_url ||= info.urls.find{|u| u["type"] == "photopage"}["_content"]
    end

    def sizes
      @size ||= PhotoSizes.new(raw_sizes.to_a)
    end

    def author
      @info.owner.username
    end

    private

    def eager_load
      info
      raw_sizes
    end

    def info
      @info ||= OpenStruct.new(FlickrAPI.get_photo_info(@id))
    end

    def raw_sizes
      @raw_sizes ||= FlickrAPI.get_photo_sizes(@id)
    end

  end
end
