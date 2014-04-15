require 'spec_helper'

module FlickrOfflineGallery
  describe PhotoSizes do

    let(:raw_flickr_response) do
      VCR.use_cassette('photo_sizes') do
        FlickrAPI.get_photo_sizes("10440808526")
      end
    end

    subject!(:sizes) { described_class.new(raw_flickr_response) }

    it "should allow access like an array" do
      expect(sizes["thumbnail"]).to be_a(PhotoSize)
      expect(sizes["thumbnail"].label).to eq("Thumbnail")
    end

    it "should respond to #each" do
      expect(sizes).to respond_to(:each)
    end
  end
end
