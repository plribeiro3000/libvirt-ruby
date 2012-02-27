module Libvirt
  module Ruby
    class Util
      extend FFI::Library

      def self.method_missing(method, *args)
        args.flatten!
        return_type = args.delete(args.last)
        dispatcher(method, args, return_type)
      end

      def self.dispatcher(method, args = [], return_type = nil)
        unless not_direct_call?
          warn "[DEPRECATION] `dispatcher` is deprecated.  Please call the function directly instead."
        end
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

      private

      def self.not_direct_call?
        caller[1][/`.*'/][1..-2] == 'method_missing'
      end
    end
  end
end