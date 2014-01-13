module FlickrOfflineGallery
  class Photo
    include VerbosePuts

    def initialize(horrible_flickraw_response_junk, args = {})
      @path_manager = args[:path_manager]
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

    def base_url
      @base_url ||= info.urls.find{|u| u["type"] == "photopage"}["_content"]
    end

    def img_filename
      @path_manager.filename_for_photo(@id, :jpg)
    end

    def full_jpg_path
      @path_manager.full_path_for(@id, :jpg)
    end

    def full_html_path
      @path_manager.full_path_for(@id, :html)
    end

    def relative_jpg_path
      @path_manager.relative_path_for(@id, :jpg)
    end

    def relative_html_path
      @path_manager.relative_path_for(@id, :html)
    end

    def back_to_index_url
      @path_manager.back_to_index
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
