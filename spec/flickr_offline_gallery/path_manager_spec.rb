require 'spec_helper'

module FlickrOfflineGallery
  describe PathManager do
    let(:base_path) { "/tmp/galleries" }
    let(:slug)      { "holiday-photos" }
    let(:photo_id)  { "1235645" }
    subject(:path_manager) { described_class.new(base_path, slug) }

    it "should have an index page named the same as the slug" do
      expect(path_manager.index_page).to eq( "/tmp/galleries/holiday-photos.html")
    end

    it "should put photos and their pages in a common folder" do
      expect(path_manager.photo_output_path).to eq( "/tmp/galleries/holiday-photos")
      expect(path_manager.full_path_for(photo_id, :jpg)).to eq( "/tmp/galleries/holiday-photos/1235645.jpg")
      expect(path_manager.full_path_for(photo_id, :html)).to eq("/tmp/galleries/holiday-photos/1235645.html")
    end

    it "should give relative links for the index page" do
      expect(path_manager.relative_path_for(photo_id, :jpg)).to eq( "holiday-photos/1235645.jpg")
      expect(path_manager.relative_path_for(photo_id, :html)).to eq("holiday-photos/1235645.html")
    end

    it "should give filenames for the photo page" do
      expect(path_manager.filename_for_photo(photo_id, :jpg)).to eq( "1235645.jpg")
    end

    it "should give 'back' links back to the index page for photo pages" do
      expect(path_manager.back_to_index).to eq( "../holiday-photos.html")
    end

  end
end
