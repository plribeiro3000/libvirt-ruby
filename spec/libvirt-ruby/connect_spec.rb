require 'spec_helper'

describe Libvirt::Ruby::Connect do
  let(:connect) { Libvirt::Ruby::Connect }

  context "when calling method #dispatcher" do
    context "with libvirt installed" do
      before :each do
        connect.stub(:ffi_lib).with("libvirt")
      end

      context "and a valid libvirt function" do
        before :each do
          connect.stub(:attach_function).with("virConnectClose", "virConnectClose", [], :int).and_return(true)
          connect.stub(:send).with("virConnectClose", [])
        end

        after :each do
          connect.dispatcher('Close', [], :int)
        end

        it "should attach it as a binding for C's function" do
          connect.should_receive(:attach_function).with("virConnectClose", "virConnectClose", [], :int).and_return(true)
        end

        it "should call the new attached method" do
          connect.should_receive(:send).with("virConnectClose", [])
        end
      end

      context "and an invalid libvirt function" do
        before :each do
          connect.stub(:attach_function).with("virConnectAbc", "virConnectAbc", [], :int).and_raise(FFI::NotFoundError.new('Abc', 'libvirt'))
        end

        it "should raise an exception" do
          lambda { connect.dispatcher('Abc', [], :int) }.should raise_error(Libvirt::Ruby::Exceptions::InvalidFunction)
        end
      end
    end

    context "without libvirt installed" do
      it "should raise an exception" do
        lambda { connect.dispatcher('Abc', [], :int) }.should raise_error(Libvirt::Ruby::Exceptions::MissingLib)
      end
    end
  end
end