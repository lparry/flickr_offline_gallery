require 'spec_helper'

module FlickrOfflineGallery
  describe PhotoPage do

    let(:photo_id) { "9579531199" }

    let(:horrible_raw_flickr_junk) do
      VCR.use_cassette('photo_with_janky_metadata') do
        FlickrAPI.get_photo_info(photo_id)
      end
    end

    let(:path_manager) { double("PathManager",
                               :back_to_index => "foo",
                               :filename_for_photo => "bar"
                               ) }
    let(:photoset_id) { "ffff" }

    let!(:photo) {

      VCR.use_cassette('full_photo_sizes_with_janky_metadata') do
        Photo.new(horrible_raw_flickr_junk,
                            :photoset_id => photoset_id,
                            :path_manager => path_manager)
      end
    }

    subject!(:photo_page) {
      described_class.new(photo)
    }

    it "should be utf-8" do
      expect(photo_page.render).to include(%(<meta http-equiv="Content-Type" content="text/html; charset=utf-8">))
    end

    it "should html encode titles/etc" do
      expect(photo_page.render).to include(%(alt="This &quot;néeds&quot; sóme &#39;fü**ed up çhara&quot;cterş"))
      expect(photo_page.render).to include(%(title="This &quot;néeds&quot; sóme &#39;fü**ed up çhara&quot;cterş by Lucas the nomad, on Flickr"))
    end
  end
end
