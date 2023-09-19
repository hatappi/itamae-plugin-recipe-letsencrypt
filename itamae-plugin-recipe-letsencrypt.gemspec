# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'itamae/plugin/recipe/letsencrypt/version'

Gem::Specification.new do |spec|
  spec.name          = "itamae-plugin-recipe-letsencrypt"
  spec.version       = Itamae::Plugin::Recipe::Letsencrypt::VERSION
  spec.authors       = ["Yusaku Hatanaka (hatappi)"]
  spec.email         = ["hata.yusaku.1225@gmail.com"]

  spec.summary       = %q{Itamae plugin to install letsencrypt}
  spec.description   = %q{Itamae plugin to install letsencrypt}
  spec.homepage      = 'https://github.com/hatappi/itamae-plugin-recipe-letsencrypt'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "itamae-plugin-resource-snappy", "~> 0.1.0"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
