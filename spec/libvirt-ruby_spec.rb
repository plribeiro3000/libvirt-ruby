require 'spec_helper'

describe Libvirt::Base do
  let(:libvirt) { Libvirt::Base.new }

  context "when calling any libvirt function directly" do
    context "without a return type specified" do
      it "should raise an error" do
        lambda { libvirt.virConnectClose }.should raise_error(Libvirt::Exceptions::NoReturnParameter)
      end
    end

    context "with libvirt installed" do
      before :each do
        libvirt.stub(:ffi_lib).with("libvirt")
      end

      context "and the function is a valid one" do
        before :each do
          libvirt.stub(:attach_function).with("virConnectClose", "virConnectClose", [], :int).and_return(true)
          libvirt.stub(:send).with("virConnectClose", [])
        end

        after :each do
          libvirt.virConnectClose([:int])
        end

        it "should attach it as a binding for C's function" do
          libvirt.should_receive(:attach_function).with("virConnectClose", "virConnectClose", [], :int).and_return(true)
        end
      end

      context "and the function is not a valid one" do
        before :each do
          libvirt.stub(:attach_function).with("virConnectAbc", "virConnectAbc", [], :int).and_raise(FFI::NotFoundError.new('Abc', 'libvirt'))
        end

        it "should raise an exception" do
          lambda { libvirt.virConnectAbc([:int]) }.should raise_error(Libvirt::Exceptions::InvalidFunction)
        end
      end
    end

    context "without libvirt installed" do
      before :each do
        libvirt.stub(:attach_function).with("virConnectAbc", "virConnectAbc", [], :int)
        libvirt.stub(:ffi_lib).and_raise(LoadError)
      end

      it "should raise an exception" do
        lambda { libvirt.virConnectAbc([:int]) }.should raise_error(Libvirt::Exceptions::MissingLib)
      end
    end
  end

  context "when calling method #dispatcher directly" do
    it "should raise an exception" do
      lambda { libvirt.send('dispatcher', 'virConnectClose', [], :int) }.should raise_error(Libvirt::Exceptions::WrongCall)
    end
  end
end