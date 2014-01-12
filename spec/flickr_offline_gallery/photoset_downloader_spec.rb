require 'spec_helper'

module FlickrOfflineGallery
  describe PhotosetDownloader do

    subject(:photoset_downloader) do
        described_class.new(photoset, selected_size)
    end
    let(:selected_size) { :thumbnail }

    let(:photoset) do
      VCR.use_cassette('photoset') do
        Photoset.new("72157639475533743")
      end
    end

    it 'should download' do
      VCR.use_cassette('photset_downloader_spec') do
        photoset_downloader.download
      end
      File.exist?(photoset.photos[0].local_jpg_path).should be_true
    end

  end

end
