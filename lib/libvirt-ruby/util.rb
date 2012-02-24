module Libvirt
  module Ruby
    module Util
      def dispatcher(method, args = [])
        begin
          return_type = args.delete(args.last)
          attach_function (self.klass + method.to_s), (self.klass + method.to_s), args, return_type
          send((self.klass + method.to_s), args)
        rescue FFI::NotFoundError
          raise Libvirt::Ruby::Exceptions::InvalidFunction.new(self.klass + method.to_s)
        end
      end
    end
  end
end