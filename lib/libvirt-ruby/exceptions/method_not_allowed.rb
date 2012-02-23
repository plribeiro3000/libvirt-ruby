module Exceptions
  class MethodNotAllowed < StandardError
    def message
      "This method should not be called direct on this module"
    end
  end
end