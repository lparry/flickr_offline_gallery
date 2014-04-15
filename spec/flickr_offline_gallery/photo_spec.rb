require 'spec_helper'

module FlickrOfflineGallery
  describe Photo do

    let(:photo_id) { "10440808526" }

    let(:horrible_raw_flickr_junk) do
      VCR.use_cassette('photo') do
        FlickrAPI.get_photo_info(photo_id)
      end
    end

    let(:path_manager) { double("PathManager") }
    let(:photoset_id) { "ffff" }

    subject!(:photo) {

      VCR.use_cassette('full_photo_sizes') do
        described_class.new(horrible_raw_flickr_junk,
                            :photoset_id => photoset_id,
                            :path_manager => path_manager)
      end
    }

    it "should have a title" do
      expect(photo.title).to eq("Giant hippo yawn")
    end

    it "should have a url" do
      expect(photo.url).to eq("https://www.flickr.com/photos/lucasthenomad/10440808526/in/set-ffff")
    end

    it "should have a base_url" do
      expect(photo.base_url).to eq("https://www.flickr.com/photos/lucasthenomad/10440808526/")
    end

    context "delegating path work to the path manager" do

      it "should ask the path manager for its img_filename" do
        path_manager.should_receive(:filename_for_photo).with(photo_id, :jpg)
        photo.img_filename
      end

      it "should ask the path manager for its full_jpg_path" do
        path_manager.should_receive(:full_path_for).with(photo_id, :jpg)
        photo.full_jpg_path
      end

      it "should ask the path manager for its full_html_path" do
        path_manager.should_receive(:full_path_for).with(photo_id, :html)
        photo.full_html_path
      end

      it "should ask the path manager for its relative_jpg_path" do
        path_manager.should_receive(:relative_path_for).with(photo_id, :jpg)
        photo.relative_jpg_path
      end

      it "should ask the path manager for its relative_html_path" do
        path_manager.should_receive(:relative_path_for).with(photo_id, :html)
        photo.relative_html_path
      end

      it "should ask the path manager for its back_to_index_url" do
        path_manager.should_receive(:back_to_index)
        photo.back_to_index_url
      end

    end

    it "should have sizes" do
      expect(photo.sizes).to be_a(PhotoSizes)
    end

    it "should have a author" do
      expect(photo.author).to eq("Lucas the nomad")
    end

  end
end
