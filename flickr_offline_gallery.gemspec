# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'flickr_offline_gallery/version'

Gem::Specification.new do |spec|
  spec.name          = "flickr_offline_gallery"
  spec.version       = FlickrOfflineGallery::VERSION
  spec.authors       = ["Lucas Parry"]
  spec.email         = ["lparry@gmail.com"]
  spec.summary       = %q{Build a local copy of a flickr photoset}
  spec.description       = %q{Build a local copy of a flickr photoset, including html embed snippets for all image sizes, for the purpose off picking photos for your blog even when there's no internet}
  spec.homepage      = ""
  spec.license       = "MIT, unless you're the NSA"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.4"
  spec.add_development_dependency "rake"
  spec.add_dependency "flickraw"
end
