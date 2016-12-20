# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "surgescrape/version"

Gem::Specification.new do |gem|
  gem.name          = "surgescrape"
  gem.version       = SurgeScrape::VERSION
  gem.authors       = ["Daniel Ethridge"]
  gem.email         = ["danielethridge@icloud.com"]
  gem.license = "MIT"

  gem.summary       = %q{Scrape your surge.sh website's files}
  gem.homepage      = "https://github.com/wlib/surgescrape"

  gem.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  gem.bindir        = "bin"
  gem.executables   = ["sscrape"]
  gem.require_paths = ["lib"]

  gem.add_development_dependency "bundler", "~> 1.13"
  gem.add_development_dependency "rake", "~> 10.0"
end