module Libvirt
  module Ruby
    module StorageVol
      def self.dispatcher(method, args = [])
        return_type = args.delete(args.last)
        attach_function ("virStorageVol" + method.to_s), ("virStorageVol" + method.to_s), args, return_type
        send(("virStorageVol" + method.to_s), args)
      end
    end
  end
end