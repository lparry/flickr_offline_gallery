require 'spec_helper'

describe FlickrOfflineGallery::PhotoSize do
  it 'should record a vcr tape' do
    VCR.use_cassette('photoset') do
      photoset = FlickrOfflineGallery::Photoset.new("72157639475533743")
      FlickrOfflineGallery.render_photoset(photoset, "thumbnail")
    end
  end
end
