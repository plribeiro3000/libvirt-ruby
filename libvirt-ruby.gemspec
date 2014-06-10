# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "libvirt/version"

Gem::Specification.new do |gem|
  gem.name        = "libvirt-ruby"
  gem.version     = Libvirt::VERSION
  gem.authors     = %q{Paulo Henrique Lopes Ribeiro}
  gem.email       = %q{plribeiro3000@gmail.com}
  gem.summary     = %q{Ruby bindings for the Libvirt C Library on the fly!}
  gem.description = %q{Access Libvirt's C Library through ruby bindings defined on the fly!}
  gem.license = 'MIT'

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.require_paths = %w(lib)

  gem.add_runtime_dependency "ffi", "> 1.0.0"
  gem.add_development_dependency "rake"
  gem.add_development_dependency "rspec", "> 2.5.0"
  gem.add_development_dependency 'coveralls'
end
