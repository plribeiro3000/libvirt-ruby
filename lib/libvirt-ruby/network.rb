module Libvirt
  module Ruby
    module Network
      def self.dispatcher(method, args = [])
        return_type = args.delete(args.last)
        attach_function ("virNetwork" + method.to_s), ("virNetwork" + method.to_s), args, return_type
        send(("virNetwork" + method.to_s), args)
      end
    end
  end
end