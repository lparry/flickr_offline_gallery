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
      sizes["thumbnail"].should be_a(PhotoSize)
      sizes["thumbnail"].label.should == "Thumbnail"
    end

    it "should respond to #each" do
      sizes.should respond_to(:each)
    end

    it "should be an openstuct (I hate this already, it'll be the first to go once the specs are done)" do
      sizes.thumbnail.should be_a(PhotoSize)
      sizes["thumbnail"].label.should == "Thumbnail"
    end
  end
end
