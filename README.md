# Libvirt::Ruby

[![Gem Version](https://badge.fury.io/rb/libvirt-ruby.png)](http://badge.fury.io/rb/libvirt-ruby) [![Build Status](https://secure.travis-ci.org/plribeiro3000/libvirt-ruby.png?branch=master)](http://travis-ci.org/plribeiro3000/libvirt-ruby) [![Dependency Status](https://gemnasium.com/plribeiro3000/libvirt-ruby.png)](https://gemnasium.com/plribeiro3000/libvirt-ruby) [![Coverage Status](https://coveralls.io/repos/plribeiro3000/libvirt-ruby/badge.png?branch=master)](https://coveralls.io/r/plribeiro3000/libvirt-ruby)  [![Code Climate](https://codeclimate.com/github/plribeiro3000/libvirt-ruby.png)](https://codeclimate.com/github/plribeiro3000/libvirt-ruby)

## Installation

Add this line to your application's Gemfile:

    gem 'libvirt-ruby'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install libvirt-ruby
    
== Dependencies

This gem has as a dependency the libvirt package. Google it and u will find how to install it on your distro.

== Usage

You may define pointers, callbacks and enums using the FFI gem. Since the main module of this gem extend it,
you can call directly on it, just like:
 Libvirt::Ruby.typedef :pointer, :pointer
 Libvirt::Ruby.callback :virFreeCallback, [:pointer], :void
 Libvirt::Ruby.enum :virStorageVolType, [:file, :block]

You should call the c function directly with the same name to attach it to the module:
 Libvirt::Ruby.virConnectClose([:int])

The only parameter of the function should be an array passing as arguments all the variables that the c function needs
and the return of the C function. After call the first time to attach, you can call the method on Libvirt::Ruby,
passing this time the real values if needed.
 Libvirt::Ruby.virConnectClose    

## Mantainers
[@plribeiro3000](https://github.com/plribeiro3000)


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request