# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pdf/reader/markup/version'

Gem::Specification.new do |spec|
  spec.name          = "pdf-reader-markup"
  spec.version       = PDF::Reader::MarkupPage::VERSION
  spec.authors       = ["Liz Conlan"]
  spec.email         = ["lizconlan@gmail.com"]
  spec.description   = %q{asdf}
  spec.summary       = %q{asdf}
  spec.homepage      = "https://github.com/lizconlan/pdf-reader-markup"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  spec.add_dependency "pdf-reader", "~> 1.3"
  spec.add_dependency "nokogiri"
  
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
