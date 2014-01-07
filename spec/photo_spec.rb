require 'spec_helper'

module FlickrOfflineGallery
  describe Photo do

    before do
      #this is horrible
      ::FlickrOfflineGallery::Variables.slug = "foo"
    end

    let(:horrible_raw_flickr_junk) do
      VCR.use_cassette('photo') do
        FlickrAPI.get_photo_info("10440808526")
      end
    end

    let(:photoset_id) { "ffff" }

    subject!(:photo) {

      VCR.use_cassette('full_photo_sizes') do
        described_class.new(horrible_raw_flickr_junk, photoset_id)
      end
    }

    it "should have a title" do
      photo.title.should == "Giant hippo yawn"
    end

    it "should have a url" do
      photo.url.should == "http://www.flickr.com/photos/83213379@N00/10440808526/in/set-ffff"
    end

    it "should have a img_filename" do
      photo.img_filename.should == "10440808526.jpg"
    end

    it "should have a local_jpg_path" do
      photo.local_jpg_path.should == "foo/10440808526.jpg"
    end

    it "should have a local_html_path" do
      photo.local_html_path.should == "foo/10440808526.html"
    end

    it "should have a base_url" do
      photo.base_url.should == "http://www.flickr.com/photos/83213379@N00/10440808526/"
    end

    it "should have sizes" do
      photo.sizes.should be_a(PhotoSizes)
    end

    it "should have a author" do
      photo.author.should == "Lucas the nomad"
    end

  end
end
