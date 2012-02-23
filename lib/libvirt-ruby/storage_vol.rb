module Libvirt
  module Ruby
    module StorageVol
      extend Libvirt::Ruby::Util

      def self.klass
        "virStorageVol"
      end
    end
  end
end