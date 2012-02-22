module Libvirt
  module Ruby
    module Connect
      def self.dispatcher(method, args = [])
        return_type = args.delete(args.last)
        attach_function ("virConnect" + method.to_s), ("virConnect" + method.to_s), args, return_type
        send(("virConnect" + method.to_s), args)
      end
    end
  end
end