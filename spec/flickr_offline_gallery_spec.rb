require 'spec_helper'

module FlickrOfflineGallery
  describe ".render_photoset" do
    it 'should record a vcr tape about photoset' do
      VCR.use_cassette('photoset') do
        photoset = Photoset.new("72157639475533743")
        ::FlickrOfflineGallery.render_photoset(photoset, "thumbnail")
      end
    end

    it 'should record a vcr tape about photo' do
      VCR.use_cassette('photo') do
        foo = FlickrAPI.get_photo_info("10440808526")
      end
    end

    it 'should record a vcr tape about photo_sizes' do
      VCR.use_cassette('photo_sizes') do
        foo = FlickrAPI.get_photo_sizes("10440808526")
      end
    end
  end
end
