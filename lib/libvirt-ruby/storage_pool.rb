module Libvirt
  module Ruby
    module StoragePool
      extend Libvirt::Ruby::Util

      def self.klass
        "virStoragePool"
      end
    end
  end
end