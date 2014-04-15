require 'spec_helper'
module FlickrOfflineGallery
  describe TemplateRenderer do
    subject(:renderer) { described_class.new(template_name) }
    let(:template_name) { "cool_template" }
    let(:test_filename) { "tmp/template_renderer_spec.html" }
    let(:template_contents) do <<-ERB
                              This is <%= variable %>!
                              ERB
    end

    it "should know where templates live" do
      expect(renderer.template_directory).to eq(File.join(GEM_ROOT, "erb"))
    end

    it "should know what template to render" do
      expect(renderer.template_path).to eq(File.join(renderer.template_directory, "#{template_name}.html.erb"))
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
      expect(renderer.template_contents).to eq(template_contents)
    end

    it "should render the template with the local variables" do
      File.stub(:exist? => true)
      File.stub(:read => template_contents)

      expect(renderer.render_erb(:variable => "awesome").strip).to eq("This is awesome!")
      expect(renderer.render_erb(:variable => "crappy").strip).to eq("This is crappy!")
    end

    it "should write the results of the render method to a file" do
      FileUtils.rm_f(test_filename)

      renderer.should_receive(:render).and_return(template_contents)

      renderer.write_file(test_filename)
      expect(File.read(test_filename)).to eq(template_contents)

    end
  end
end
