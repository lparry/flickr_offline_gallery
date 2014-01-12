module FlickrOfflineGallery
  module VerbosePuts
    def verbose_puts(string)
      puts(string) if ENV["VERBOSE"]
      string
    end
  end
end
