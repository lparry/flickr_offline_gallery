require 'spec_helper'

module FlickrOfflineGallery

  describe GalleryGenerator do
    subject!(:photoset) do
      VCR.use_cassette('photoset') do
        Photoset.new("72157639475533743",
                     :output_path => SPEC_TMP_DIR)
      end
    end

    subject(:generator) { described_class.new(photoset) }

    it "Should render a photoset gallery" do
      VCR.use_cassette('image_downloads') do
        generator.render_photoset("medium")
      end
      Dir.glob(File.join(SPEC_TMP_DIR, "**", "*")).map do |path|
        path.sub(SPEC_TMP_DIR, '')
      end.should == [ "/flickr-offline-gallery-specs",
                      "/flickr-offline-gallery-specs/10440808526.html",
                      "/flickr-offline-gallery-specs/10440808526.jpg",
                      "/flickr-offline-gallery-specs/11224643544.html",
                      "/flickr-offline-gallery-specs/11224643544.jpg",
                      "/flickr-offline-gallery-specs/11439134074.html",
                      "/flickr-offline-gallery-specs/11439134074.jpg",
                      "/flickr-offline-gallery-specs/9579531199.html",
                      "/flickr-offline-gallery-specs/9579531199.jpg",
                      "/flickr-offline-gallery-specs.html"]
    end

  end

  describe 'VerbosePuts mixin' do
    class TestPuts
      include FlickrOfflineGallery::VerbosePuts
    end

    subject(:test_class) { TestPuts.new }

    before do
      @old_verbose = ENV["VERBOSE"]
    end

    after do
      ENV["VERBOSE"] = @old_verbose
    end

    it "should puts if the env var VERBOSE is set" do
      ENV["VERBOSE"] = 'true'
      test_class.should_receive(:puts).with("test string")
      test_class.verbose_puts "test string"
    end

    it "should not puts if the env var VERBOSE is not set" do
      ENV["VERBOSE"] = nil
      test_class.should_not_receive(:puts).with("test string")
      test_class.verbose_puts "test string"
    end
  end
end
