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
    render_photoset_index_page(photoset)
  end

  def self.render_photoset_index_page(photoset)
    File.open("#{photoset.slug}.html", "w") do |f|
      f.write render_erb("photoset", :photoset => photoset, :photos => photoset.photos, :size => "medium")
    end
   ::FlickrOfflineGallery.verbose_puts "#{photoset.slug}.html"
  end

  def self.render_photo_pages(photoset)
    photoset.photos.each do |p|
      render_photo_page(p)
    end
  end

  def self.render_photo_page(photo)
    File.open(photo.local_html_path, "w") do |f|
      f.write render_erb("photo",
                         :index_page => photo.local_html_path.sub(/\/.*/, ".html"),
                         :source => photo.img_filename,
                         :sizes => photo.sizes,
                         :photo_url => photo.url,
                         :title => photo.title,
                         :author => photo.author)
    end
   ::FlickrOfflineGallery.verbose_puts "Rendered #{photo.local_html_path}"
  end


  def self.verbose_puts(string)
   ::FlickrOfflineGallery.verbose_puts(string) if ENV["VERBOSE"]
    string
  end
end
