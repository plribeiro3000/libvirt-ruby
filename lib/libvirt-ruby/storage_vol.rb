module Libvirt
  module Ruby
    class StorageVol
      attr_accessor :klass

      def initialize
        @klass = "virStorageVol"
      end

      def method_missing(method)
        @klass << method.to_s.downcase.capitalize
        self
      end
    end
  end
end