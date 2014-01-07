require 'flickraw'
require 'erb'
require 'fileutils'

require "flickr_offline_gallery/version"
require "flickr_offline_gallery/photo_size"
require "flickr_offline_gallery/photo_sizes"
require "flickr_offline_gallery/photo"
require "flickr_offline_gallery/photoset"
require "flickr_offline_gallery/photoset_downloader"
require "flickr_offline_gallery/flickr_a_p_i"
require "flickr_offline_gallery/template_renderer"
require "flickr_offline_gallery/photo_page"
require "flickr_offline_gallery/photoset_index_page"

module FlickrOfflineGallery
  class Variables
    class << self
      attr_accessor :slug
    end
  end

  def self.download(photoset, size = "medium_800")
    PhotosetDownloader.new(photoset, size).download
  end

  def self.render_photoset(photoset, size)
    download(photoset, size)
    render_photo_pages(photoset)
    PhotosetIndexPage.new(photoset).write
  end

  def self.render_photo_pages(photoset)
    photoset.photos.each do |p|
      PhotoPage.new(p).write
    end
  end


  def self.verbose_puts(string)
    puts(string) if ENV["VERBOSE"]
    string
  end
end
