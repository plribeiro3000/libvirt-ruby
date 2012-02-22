module Libvirt
  module Ruby
    module Domain
      def self.dispatcher(method, args = [])
        return_type = args.delete(args.last)
        attach_function ("virDomain" + method.to_s), ("virDomain" + method.to_s), args, return_type
        send(("virDomain" + method.to_s), args)
      end
    end
  end
end