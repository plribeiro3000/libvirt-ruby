module Libvirt
  module Ruby
    module Exceptions
      class NoReturnParameter < StandardError
        def initialize
          super("No Return Parameter was Specified. It was by purpose?")
        end
      end
    end
  end
end