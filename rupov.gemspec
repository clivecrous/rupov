# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "rupov/version"

Gem::Specification.new do |s|
  s.name        = "rupov"
  s.version     = RuPov::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Clive Crous"]
  s.email       = ["clive@crous.co.za"]
  s.homepage    = "http://www.darkarts.co.za/rupov"
  s.summary     = %q{A Ruby library for creating PovRay scenes using Ruby}
  s.description = %q{A Ruby library for creating PovRay scenes using Ruby}

  s.add_development_dependency "bundler", ">= 1.0.0"
  s.add_development_dependency "rspec", ">= 1.3.0"
  s.add_development_dependency "rake", ">= 0.8.7"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
