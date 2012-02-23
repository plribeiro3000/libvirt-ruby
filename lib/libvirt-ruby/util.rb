module Libvirt
  module Ruby
    module Util
      def dispatcher(method, args = [])
        raise Exceptions::MethodNotAllowed if self.instance_of?(Libvirt::Ruby::Util)
        return_type = args.delete(args.last)
        attach_function (self.klass + method.to_s), (self.klass + method.to_s), args, return_type
        send((self.klass + method.to_s), args)
      end
    end
  end
end