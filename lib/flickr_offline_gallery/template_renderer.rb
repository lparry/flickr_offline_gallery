module FlickrOfflineGallery
  class TemplateRenderer
    def initialize(template)
      @template = template
    end

    def template_path
      File.expand_path("../../../erb/#{@template}.html.erb",__FILE__)
    end

    def template_directory
      File.expand_path("../../../erb/", __FILE__)
    end

    def template_contents
      raise "Unknown template: #{template_path}" unless File.exist?(template_path)
      @template_content ||= File.read(template_path)
    end

    def render(locals)
      ERB.new(template_contents).result(OpenStruct.new(locals).instance_eval { binding })
    end
  end
end
