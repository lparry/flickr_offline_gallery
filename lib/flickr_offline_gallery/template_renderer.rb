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

    def render_erb(locals)
      ERB.new(template_contents).result(OpenStruct.new(locals).instance_eval { binding })
    end

    def render
      raise "not implemented"
    end

    def write
      raise "not implemented"
    end

    def write_file(filename)
      File.open(filename, 'w') do |file|
        file.write render
      end
      ::FlickrOfflineGallery.verbose_puts "Wrote out #{filename}"
    end
  end
end
