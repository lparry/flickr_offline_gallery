require 'spec_helper'
module FlickrOfflineGallery
  describe TemplateRenderer do
    subject(:renderer) { described_class.new(template_name) }
    let(:template_name) { "cool_template" }
    let(:template_contents) do <<-ERB
                              This is <%= variable %>!
                              ERB
    end

    it "should know where templates live" do
      renderer.template_directory.should == File.join(GEM_ROOT, "erb")
    end

    it "should know what template to render" do
      renderer.template_path.should == File.join(renderer.template_directory, "#{template_name}.html.erb")
    end

    it "should raise an error if the template is missing" do
      File.should_receive(:exist?).and_return(false)
      expect {
        renderer.template_contents
      }.to raise_error("Unknown template: #{renderer.template_path}")
    end

    it "should read in the correct template" do
      File.stub(:exist? => true)
      File.stub(:read => template_contents)
      renderer.template_contents.should == template_contents
    end

    it "should render the template with the local variables" do
      File.stub(:exist? => true)
      File.stub(:read => template_contents)

      renderer.render(:variable => "awesome").strip.should == "This is awesome!"
      renderer.render(:variable => "crappy").strip.should == "This is crappy!"
    end
  end
end
