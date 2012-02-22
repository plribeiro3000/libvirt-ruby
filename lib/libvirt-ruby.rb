require "ffi"
require "libvirt-ruby/version"

module Libvirt
  module Ruby

    extend FFI::Library
    ffi_lib "libvirt"

    autoload :Connect, 'libvirt-ruby/connect'
    autoload :Domain, 'libvirt-ruby/domain'
    autoload :Network, 'libvirt-ruby/network'
    autoload :StoragePool, 'libvirt-ruby/storage_pool'
    autoload :StorageVol, 'libvirt-ruby/storage_vol'
  end
end