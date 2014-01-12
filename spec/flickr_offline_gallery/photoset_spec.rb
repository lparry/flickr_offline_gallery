require 'spec_helper'

module FlickrOfflineGallery
  describe Photoset do
    subject(:photoset) do
      VCR.use_cassette('photoset') do
        described_class.new("72157639475533743")
      end
    end

    it 'should have a username' do
      photoset.username.should == "Lucas the nomad"
    end

    it 'should have a title' do
      photoset.title.should == "flickr_offline_gallery specs"
    end

    it 'should have a slug' do
      photoset.slug.should == "flickr-offline-gallery-specs"
    end

    it 'should have a photos' do
      photoset.photos.count.should == 4
      photoset.photos.first.title.should == "Purdy lamps"
    end

    it "should have an index page filename" do
      photoset.index_page_filename.should == "#{Variables.output_directory}/flickr-offline-gallery-specs.html"
    end

  end

end
