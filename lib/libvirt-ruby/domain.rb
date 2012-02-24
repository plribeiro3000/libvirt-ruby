module Libvirt
  module Ruby
    module Domain
      extend Libvirt::Ruby::Util
      extend FFI::Library

      begin
        ffi_lib "libvirt.so.0"
      rescue LoadError
        raise Libvirt::Ruby::Exceptions::MissingLib
      end

      def self.klass
        "virDomain"
      end
    end
  end
end