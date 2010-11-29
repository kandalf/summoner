# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "wizard/version"

Gem::Specification.new do |s|
  s.name        = "wizard"
  s.version     = Wizard::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Leonardo Mateo"]
  s.email       = ["leonardomateo@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Simple Ruby fixtures replacement.}
  s.description = %q{Simple Ruby Fixtures replacement like Factory Girl, and many others, but based on simplicity.}

  s.rubyforge_project = "wizard"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
