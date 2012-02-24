module Libvirt
  module Ruby
    module Exceptions
      class MissingLib < StandardError
        def initialize
          super("The libvirt C library could not be loaded. Is it properly installed?")
        end
      end
    end
  end
end