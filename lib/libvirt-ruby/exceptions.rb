module Libvirt
  module Ruby
    module Exceptions
      autoload :MissingLib, 'libvirt-ruby/exceptions/missing_lib'
      autoload :InvalidFunction, 'libvirt-ruby/exceptions/invalid_function'
    end
  end
end