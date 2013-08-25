module Libvirt
  module Exceptions
    autoload :MissingLib, 'libvirt/exceptions/missing_lib'
    autoload :InvalidFunction, 'libvirt/exceptions/invalid_function'
    autoload :NoReturnParameter, 'libvirt/exceptions/no_return_parameter'
    autoload :WrongCall, 'libvirt/exceptions/wrong_call'
  end
end