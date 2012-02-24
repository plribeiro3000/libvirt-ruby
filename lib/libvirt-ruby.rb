require "libvirt-ruby/version"
require "ffi"

module Libvirt
  module Ruby
    autoload :Connect, 'libvirt-ruby/connect'
    autoload :Domain, 'libvirt-ruby/domain'
    autoload :Exceptions, 'libvirt-ruby/exceptions'
    autoload :Network, 'libvirt-ruby/network'
    autoload :StoragePool, 'libvirt-ruby/storage_pool'
    autoload :StorageVol, 'libvirt-ruby/storage_vol'
    autoload :Util, 'libvirt-ruby/util'
  end
end