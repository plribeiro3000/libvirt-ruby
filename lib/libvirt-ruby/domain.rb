module Libvirt
  module Ruby
    class Domain
      attr_accessor :klass

      def initialize
        @klass = "virDomain"
      end

      def method_missing(method)
        @klass << method.to_s.downcase.capitalize
        self
      end
    end
  end
end