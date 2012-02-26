module Libvirt
  module Ruby
    class StoragePool < Libvirt::Ruby::Util
      def self.klass
        "virStoragePool"
      end
    end
  end
end