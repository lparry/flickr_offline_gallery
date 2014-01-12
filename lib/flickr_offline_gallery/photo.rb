module FlickrOfflineGallery
  class Photo
    include VerbosePuts

    def initialize(horrible_flickraw_response_junk, args = {})
      @output_path = args[:output_path]
      @id = horrible_flickraw_response_junk["id"]
      @photoset_id = args[:photoset_id]
      eager_load
      verbose_puts %(Fetched data about photo #{@id}: "#{title}")
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

    def html_filename
      "#{@id}.html"
    end

    def local_jpg_path
      "#{@output_path}/#{img_filename}"
    end

    def local_html_path
      "#{@output_path}/#{html_filename}"
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
