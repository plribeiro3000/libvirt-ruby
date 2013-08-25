module Libvirt
  module Exceptions
    class InvalidFunction < StandardError
      def initialize(function)
        super("The function '#{function}' could not be found. Is it correct?")
      end
    end
  end
end