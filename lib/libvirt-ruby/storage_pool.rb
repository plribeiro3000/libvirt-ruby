module Libvirt
  module Ruby
    class StoragePool
      attr_accessor :klass

      def initialize
        @klass = "virStoragePool"
      end

      def method_missing(method)
        @klass << method.to_s.downcase.capitalize
        self
      end
    end
  end
end