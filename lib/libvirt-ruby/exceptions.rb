module Libvirt
  module Exceptions
    autoload :MissingLib, 'libvirt-ruby/exceptions/missing_lib'
    autoload :InvalidFunction, 'libvirt-ruby/exceptions/invalid_function'
    autoload :NoReturnParameter, 'libvirt-ruby/exceptions/no_return_parameter'
    autoload :WrongCall, 'libvirt-ruby/exceptions/wrong_call'
  end
end