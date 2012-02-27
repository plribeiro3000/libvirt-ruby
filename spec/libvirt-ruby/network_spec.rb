require 'spec_helper'

describe Libvirt::Ruby::Network do
  let(:network) { Libvirt::Ruby::Network }

  context "when calling method #dispatcher" do
    context "that is now deprecated" do
      before :each do
        network.stub(:ffi_lib).with("libvirt")
        network.stub(:attach_function).with("virNetworkRef", "virNetworkRef", [], :int)
        network.stub(:send).with("virNetworkRef", [])
      end

      it "should raise a deprecated method warning" do
        network.should_receive(:warn).with("[DEPRECATION] `dispatcher` is deprecated.  Please call the function directly instead.")
        network.dispatcher('Ref', [], :int)
      end
    end

    context "with libvirt installed" do
      before :each do
        network.stub(:warn).with("[DEPRECATION] `dispatcher` is deprecated.  Please call the function directly instead.")
        network.stub(:ffi_lib).with("libvirt")
      end

      context "and a valid libvirt function" do
        before :each do
          network.stub(:attach_function).with("virNetworkRef", "virNetworkRef", [], :int).and_return(true)
          network.stub(:send).with("virNetworkRef", [])
        end

        after :each do
          network.dispatcher('Ref', [], :int)
        end

        it "should attach it as a binding for C's function" do
          network.should_receive(:attach_function).with("virNetworkRef", "virNetworkRef", [], :int).and_return(true)
        end

        it "should call the new attached method" do
          network.should_receive(:send).with("virNetworkRef", [])
        end
      end

      context "and an invalid libvirt function" do
        before :each do
          network.stub(:attach_function).with("virNetworkAbc", "virNetworkAbc", [], :int).and_raise(FFI::NotFoundError.new('Abc', 'libvirt'))
        end

        it "should raise an exception" do
          lambda { network.dispatcher('Abc', [], :int) }.should raise_error(Libvirt::Ruby::Exceptions::InvalidFunction)
        end
      end
    end

    context "without libvirt installed" do
      before :each do
        network.stub(:warn).with("[DEPRECATION] `dispatcher` is deprecated.  Please call the function directly instead.")
      end

      it "should raise an exception" do
        lambda { network.dispatcher('Abc', [], :int) }.should raise_error(Libvirt::Ruby::Exceptions::MissingLib)
      end
    end
  end

  context "when calling any libvirt function directly" do
    context "that is the new way" do
      before :each do
        network.stub(:ffi_lib).with("libvirt")
        network.stub(:attach_function).with("virNetworkRef", "virNetworkRef", [], :int)
        network.stub(:send).with("virNetworkRef", [])
      end

      it "should  not raise a deprecated method warning" do
        network.should_not_receive(:warn).with("[DEPRECATION] `dispatcher` is deprecated.  Please call the function directly instead.")
        network.Ref([:int])
      end
    end

    context "with libvirt installed" do
      before :each do
        network.stub(:ffi_lib).with("libvirt")
      end

      context "and the function is a valid one" do
        before :each do
          network.stub(:attach_function).with("virNetworkRef", "virNetworkRef", [], :int).and_return(true)
          network.stub(:send).with("virNetworkRef", [])
        end

        after :each do
          network.Ref([:int])
        end

        it "should attach it as a binding for C's function" do
          network.should_receive(:attach_function).with("virNetworkRef", "virNetworkRef", [], :int).and_return(true)
        end

        it "should call the new attached method" do
          network.should_receive(:send).with("virNetworkRef", [])
        end
      end

      context "and the function is not a valid one" do
        before :each do
          network.stub(:attach_function).with("virNetworkAbc", "virNetworkAbc", [], :int).and_raise(FFI::NotFoundError.new('Abc', 'libvirt'))
        end

        it "should raise an exception" do
          lambda { network.Abc([:int]) }.should raise_error(Libvirt::Ruby::Exceptions::InvalidFunction)
        end
      end
    end

    context "without libvirt installed" do
      it "should raise an exception" do
        lambda { network.Abc([:int]) }.should raise_error(Libvirt::Ruby::Exceptions::MissingLib)
      end
    end
  end
end