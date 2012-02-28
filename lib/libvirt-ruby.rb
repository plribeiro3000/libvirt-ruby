require "libvirt-ruby/version"
require "ffi"

module Libvirt
  module Ruby
    autoload :Exceptions, 'libvirt-ruby/exceptions'

    extend FFI::Library

    def self.method_missing(method, *args)
      args.flatten!
      return_type = args.delete(args.last)
      raise Libvirt::Ruby::Exceptions::NoReturnParameter unless return_type
      dispatcher(method, args, return_type)
    end

    private

    def self.dispatcher(method, args = [], return_type = nil)
      raise Libvirt::Ruby::Exceptions::WrongCall unless not_direct_call?
      begin
        ffi_lib "libvirt"
        attach_function method.to_s, method.to_s, args, return_type
        send method.to_s, args
      rescue FFI::NotFoundError
        raise Libvirt::Ruby::Exceptions::InvalidFunction.new(method.to_s)
      rescue LoadError
        raise Libvirt::Ruby::Exceptions::MissingLib
      end
    end

    def self.not_direct_call?
      caller[1][/`.*'/] and caller[1][/`.*'/][1..-2] == 'method_missing'
    end
  end
end