require 'spec_helper'

module FlickrOfflineGallery

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
