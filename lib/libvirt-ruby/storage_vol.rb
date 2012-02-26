module Libvirt
  module Ruby
    class StorageVol < Libvirt::Ruby::Util
      def self.klass
        "virStorageVol"
      end
    end
  end
end