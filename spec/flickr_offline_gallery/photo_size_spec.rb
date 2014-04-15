require 'spec_helper'

module FlickrOfflineGallery
  describe PhotoSize do

    subject!(:size) {
      VCR.use_cassette('photo_sizes') do
        described_class.new(FlickrAPI.get_photo_sizes("10440808526")[2])
      end
    }

    it "should should know its label" do
      expect(size.label).to eq("Thumbnail")
    end

    it "should should know its height" do
      expect(size.height).to eq("75")
    end

    it "should should know its width" do
      expect(size.width).to eq("100")
    end

    it "should should know its url" do
      expect(size.url).to eq("https://farm8.staticflickr.com/7402/10440808526_c3fd515635_t.jpg")
    end

    it 'should know its filename friendly key' do
      expect(size.key).to eq("thumbnail")
    end
  end
end
