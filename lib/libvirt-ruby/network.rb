module Libvirt
  module Ruby
    class Network
      attr_accessor :klass

      def initialize
        @klass = "virNetwork"
      end

      def method_missing(method)
        @klass << method.to_s.downcase.capitalize
        self
      end
    end
  end
end