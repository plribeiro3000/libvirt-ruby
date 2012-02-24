module Libvirt
  module Ruby
    module Network
      extend Libvirt::Ruby::Util
      extend FFI::Library

      begin
        ffi_lib "libvirt.so.0"
      rescue LoadError
        raise Libvirt::Ruby::Exceptions::MissingLib
      end

      def self.klass
        "virNetwork"
      end
    end
  end
end