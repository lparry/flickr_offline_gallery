module FlickrOfflineGallery
  class Photo

    attr_reader :id, :secret, :set

    def initialize(horrible_flickraw_response_junk, photoset_id = nil)
      @id = horrible_flickraw_response_junk["id"]
      @secret = horrible_flickraw_response_junk["secret"]
      @set = photoset_id
      info
      raw_sizes
      puts "initialized photo '#{title}'"
      nil
    end

    def title
      info.title
    end

    def date
      @date ||= DateTime.parse(info.dates["taken"])
    end

    def url
      if set
        "#{base_url}in/set-#{set}"
      else
        base_url
      end
    end

    def base_url
      @base_url ||= info.urls.find{|u| u["type"] == "photopage"}["_content"]
    end

    def sizes
      @size ||= PhotoSizes.new(raw_sizes.to_a)
    end

    private

    def info
      @info ||= OpenStruct.new(flickr.photos.getInfo(:photo_id => @id).to_hash)
    end

    def raw_sizes
      @raw_sizes ||= flickr.photos.getSizes :photo_id => @id
    end

  end
end
