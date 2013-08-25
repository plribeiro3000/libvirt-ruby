require "libvirt-ruby/version"
require "ffi"

module Libvirt
  autoload :Exceptions, 'libvirt-ruby/exceptions'

  class Base
    extend FFI::Library

    def method_missing(method, *args)
      args.flatten!
      return_type = args.delete(args.last)
      raise Libvirt::Exceptions::NoReturnParameter unless return_type
      dispatcher(method, args, return_type)
    end

    private

    def dispatcher(method, args = [], return_type = nil)
      raise Libvirt::Exceptions::WrongCall unless not_direct_call?
      begin
        ffi_lib "libvirt"
        attach_function method.to_s, method.to_s, args, return_type
      rescue FFI::NotFoundError
        raise Libvirt::Exceptions::InvalidFunction.new(method.to_s)
      rescue LoadError
        raise Libvirt::Exceptions::MissingLib
      end
    end

    def not_direct_call?
      caller[1][/`.*'/] and caller[1][/`.*'/][1..-2] == 'method_missing'
    end
  end
end