require 'flickraw'
require 'erb'

require "flickr_offline_gallery/version"
require "flickr_offline_gallery/photo_size"
require "flickr_offline_gallery/photo_sizes"
require "flickr_offline_gallery/photo"
require "flickr_offline_gallery/photoset"
require "flickr_offline_gallery/photoset_downloader"

FlickRaw.api_key       = "#{ENV["FLICKR_API_KEY"]}"
FlickRaw.shared_secret = "#{ENV["FLICKR_SHARED_SECRET"]}"

module FlickrOfflineGallery
  class Variables
    class << self
      attr_accessor :slug
    end
  end

  def self.photoset
    @photoset ||= Photoset.new("72157638802576105")
    Variables.slug = @photoset.slug
    @photoset
  end

  def self.download
    PhotosetDownloader.new(photoset).download
  end

  def self.render_photoset(photoset)
    download(photoset)
    render_photo_pages(photoset)
    render_photoset_index_page(photoset)
  end

  def self.render_photoset_index_page(photoset)
    File.open("#{photoset.slug}.html", "w") do |f|
      f.write render_erb("photoset", :photoset => photoset, :photos => photoset.photos, :size => "medium")
    end
  end

  def self.render_photo_pages(photoset)
    photoset.photos.each do |p|
      render_photo_page(p)
    end
  end

  def self.render_photo_page(photo)
    File.open(photo.local_html_path, "w") do |f|
      f.write render_erb("photo", :source => photo.img_filename, :sizes => photo.sizes, :photo_url => photo.url, :title => photo.title, :author => photo.author)
    end
  end

  def self.render_erb(template, locals)
    full_template_path = "#{File.join(File.dirname(__FILE__), "erb",template)}.html.erb"
    raise "unknown template: #{full_template_path}" unless File.exist?(full_template_path)
    ERB.new(File.read(full_template_path)).result(OpenStruct.new(locals).instance_eval { binding })
  end
end
