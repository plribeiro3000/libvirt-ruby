module Libvirt
  module Ruby
    module StoragePool
      def self.dispatcher(method, args = [])
        return_type = args.delete(args.last)
        attach_function ("virStoragePool" + method.to_s), ("virStoragePool" + method.to_s), args, return_type
        send(("virStoragePool" + method.to_s), args)
      end
    end
  end
end