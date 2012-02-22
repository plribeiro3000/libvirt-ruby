# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "libvirt-ruby/version"

Gem::Specification.new do |s|
  s.name        = "libvirt-ruby"
  s.version     = Libvirt::Ruby::VERSION
  s.authors     = %q{Paulo Henrique Lopes Ribeiro}
  s.email       = %q{plribeiro3000@gmail.com}
  s.homepage    = ""
  s.summary     = %q{Ruby bindings for the Libvirt C Library}
  s.description = %q{Access Libvirt's C Library through ruby classes and methods}

  s.rubyforge_project = "libvirt-ruby"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = %w(lib)

  s.add_runtime_dependency "ffi"
  s.add_development_dependency "rspec"
end