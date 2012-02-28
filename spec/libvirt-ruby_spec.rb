require 'spec_helper'

describe Libvirt::Ruby do
  let(:libvirt) { Libvirt::Ruby }

  context "when calling any libvirt function directly" do
    context "without a return type specified" do
      it "should raise an error" do
        lambda { libvirt.virConnectClose }.should raise_error(Libvirt::Ruby::Exceptions::NoReturnParameter)
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

        it "should call the new attached method" do
          libvirt.should_receive(:send).with("virConnectClose", [])
        end
      end

      context "and the function is not a valid one" do
        before :each do
          libvirt.stub(:attach_function).with("virConnectAbc", "virConnectAbc", [], :int).and_raise(FFI::NotFoundError.new('Abc', 'libvirt'))
        end

        it "should raise an exception" do
          lambda { libvirt.virConnectAbc([:int]) }.should raise_error(Libvirt::Ruby::Exceptions::InvalidFunction)
        end
      end
    end

    context "without libvirt installed" do
      it "should raise an exception" do
        lambda { libvirt.virConnectAbc([:int])  }.should raise_error(Libvirt::Ruby::Exceptions::MissingLib)
      end
    end
  end

  context "when calling method #dispatcher directly" do
    it "should raise an exception" do
      lambda { libvirt.dispatcher('virConnectClose', [], :int) }.should raise_error(Libvirt::Ruby::Exceptions::WrongCall)
    end
  end
end