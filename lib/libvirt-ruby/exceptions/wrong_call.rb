module Libvirt
  module Ruby
    module Exceptions
      class WrongCall < StandardError
        def initialize
          super("This method cannot be called directly. It was by purpose?")
        end
      end
    end
  end
end