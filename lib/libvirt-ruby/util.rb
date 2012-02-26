module Libvirt
  module Ruby
    class Util
      extend FFI::Library

      def self.dispatcher(method, args = [], return_type)
        begin
          ffi_lib "libvirt"
          attach_function (self.klass + method.to_s), (self.klass + method.to_s), args, return_type
          send (self.klass + method.to_s), args
        rescue FFI::NotFoundError
          raise Libvirt::Ruby::Exceptions::InvalidFunction.new(self.klass + method.to_s)
        rescue LoadError
          raise Libvirt::Ruby::Exceptions::MissingLib
        end
      end
    end
  end
end