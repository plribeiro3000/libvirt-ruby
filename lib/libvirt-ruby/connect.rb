module Libvirt
  module Ruby
    class Connect
      attr_accessor :klass

      def initialize
        @klass = "virConnect"
      end

      def method_missing(method)
        @klass << method.to_s.downcase.capitalize
        self
      end
    end
  end
end