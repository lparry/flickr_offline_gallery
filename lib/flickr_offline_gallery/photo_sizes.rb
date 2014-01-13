module FlickrOfflineGallery
  class PhotoSizes

    def initialize(raw_sizes)
       @sizes = Hash[raw_sizes.map do |s|
         size = PhotoSize.new(s)
         [size.key, size]
       end]
    end

    def [](key)
      @sizes[key.to_s]
    end

    def each
      @sizes.values.each do |value|
        yield(value)
      end
    end
  end
end
