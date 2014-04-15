require 'spec_helper'

module FlickrOfflineGallery
  describe Photoset do
    subject(:photoset) do
      VCR.use_cassette('photoset') do
        described_class.new("72157639475533743",
                           :output_path => SPEC_TMP_DIR)
      end
    end

    it 'should have a username' do
      expect(photoset.username).to eq("Lucas the nomad")
    end

    it 'should have a title' do
      expect(photoset.title).to eq("flickr_offline_gallery specs")
    end

    it 'should have a slug' do
      expect(photoset.slug).to eq("flickr-offline-gallery-specs")
    end

    it 'should have a photos' do
      expect(photoset.photos.count).to eq(4)
      expect(photoset.photos.first.title).to eq("Purdy lamps")
    end

    it "should have an index page filename" do
      expect(photoset.index_page_filename).to eq("#{SPEC_TMP_DIR}/flickr-offline-gallery-specs.html")
    end

  end

end
