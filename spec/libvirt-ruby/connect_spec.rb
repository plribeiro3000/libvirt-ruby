require 'spec_helper'

describe Libvirt::Ruby::Connect do
  let(:connect) { Libvirt::Ruby::Connect }

  context "when calling method #dispatcher" do
    context "that is now deprecated" do
      before :each do
        connect.stub(:ffi_lib).with("libvirt")
        connect.stub(:attach_function).with("virConnectClose", "virConnectClose", [], :int)
        connect.stub(:send).with("virConnectClose", [])
      end

      it "should raise a deprecated method warning" do
        connect.should_receive(:warn).with("[DEPRECATION] `dispatcher` is deprecated.  Please call the function directly instead.")
        connect.dispatcher('Close', [], :int)
      end
    end

    context "with libvirt installed" do
      before :each do
        connect.stub(:warn).with("[DEPRECATION] `dispatcher` is deprecated.  Please call the function directly instead.")
        connect.stub(:ffi_lib).with("libvirt")
      end

      context "and a valid libvirt function" do
        before :each do
          connect.stub(:attach_function).with("virConnectClose", "virConnectClose", [], :int)
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
      before :each do
        connect.stub(:warn).with("[DEPRECATION] `dispatcher` is deprecated.  Please call the function directly instead.")
      end

      it "should raise an exception" do
        lambda { connect.dispatcher('Abc', [], :int) }.should raise_error(Libvirt::Ruby::Exceptions::MissingLib)
      end
    end
  end

  context "when calling any libvirt function directly" do
    context "that is the new way" do
      before :each do
        connect.stub(:ffi_lib).with("libvirt")
        connect.stub(:attach_function).with("virConnectClose", "virConnectClose", [], :int)
        connect.stub(:send).with("virConnectClose", [])
      end

      it "should  not raise a deprecated method warning" do
        connect.should_not_receive(:warn).with("[DEPRECATION] `dispatcher` is deprecated.  Please call the function directly instead.")
        connect.Close([:int])
      end
    end

    context "with libvirt installed" do
      before :each do
        connect.stub(:ffi_lib).with("libvirt")
      end

      context "and the function is a valid one" do
        before :each do
          connect.stub(:attach_function).with("virConnectClose", "virConnectClose", [], :int).and_return(true)
          connect.stub(:send).with("virConnectClose", [])
        end

        after :each do
          connect.Close([:int])
        end

        it "should attach it as a binding for C's function" do
          connect.should_receive(:attach_function).with("virConnectClose", "virConnectClose", [], :int).and_return(true)
        end

        it "should call the new attached method" do
          connect.should_receive(:send).with("virConnectClose", [])
        end
      end

      context "and the function is not a valid one" do
        before :each do
          connect.stub(:attach_function).with("virConnectAbc", "virConnectAbc", [], :int).and_raise(FFI::NotFoundError.new('Abc', 'libvirt'))
        end

        it "should raise an exception" do
          lambda { connect.Abc([:int]) }.should raise_error(Libvirt::Ruby::Exceptions::InvalidFunction)
        end
      end
    end

    context "without libvirt installed" do
      it "should raise an exception" do
        lambda { connect.Abc([:int])  }.should raise_error(Libvirt::Ruby::Exceptions::MissingLib)
      end
    end
  end
end