require 'spec_helper'

describe Libvirt::Ruby::Domain do
  let(:domain) { Libvirt::Ruby::Domain }

  context "when calling method #dispatcher" do
    context "that is now deprecated" do
      before :each do
        domain.stub(:ffi_lib).with("libvirt")
        domain.stub(:attach_function).with("virDomainCreate", "virDomainCreate", [], :int)
        domain.stub(:send).with("virDomainCreate", [])
      end

      it "should raise a deprecated method warning" do
        domain.should_receive(:warn).with("[DEPRECATION] `dispatcher` is deprecated.  Please call the function directly instead.")
        domain.dispatcher('Create', [], :int)
      end
    end

    context "with libvirt installed" do
      before :each do
        domain.stub(:warn).with("[DEPRECATION] `dispatcher` is deprecated.  Please call the function directly instead.")
        domain.stub(:ffi_lib).with("libvirt")
      end

      context "and a valid libvirt function" do
        before :each do
          domain.stub(:attach_function).with("virDomainCreate", "virDomainCreate", [], :int).and_return(true)
          domain.stub(:send).with("virDomainCreate", [])
        end

        after :each do
          domain.dispatcher('Create', [], :int)
        end

        it "should attach it as a binding for C's function" do
          domain.should_receive(:attach_function).with("virDomainCreate", "virDomainCreate", [], :int).and_return(true)
        end

        it "should call the new attached method" do
          domain.should_receive(:send).with("virDomainCreate", [])
        end
      end

      context "and an invalid libvirt function" do
        before :each do
          domain.stub(:attach_function).with("virDomainAbc", "virDomainAbc", [], :int).and_raise(FFI::NotFoundError.new('Abc', 'libvirt'))
        end

        it "should raise an exception" do
          lambda { domain.dispatcher('Abc', [], :int) }.should raise_error(Libvirt::Ruby::Exceptions::InvalidFunction)
        end
      end
    end

    context "without libvirt installed" do
      before :each do
        domain.stub(:warn).with("[DEPRECATION] `dispatcher` is deprecated.  Please call the function directly instead.")
      end

      it "should raise an exception" do
        lambda { domain.dispatcher('Abc', [], :int) }.should raise_error(Libvirt::Ruby::Exceptions::MissingLib)
      end
    end
  end

  context "when calling any libvirt function directly" do
    context "that is the new way" do
      before :each do
        domain.stub(:ffi_lib).with("libvirt")
        domain.stub(:attach_function).with("virDomainCreate", "virDomainCreate", [], :int)
        domain.stub(:send).with("virDomainCreate", [])
      end

      it "should  not raise a deprecated method warning" do
        domain.should_not_receive(:warn).with("[DEPRECATION] `dispatcher` is deprecated.  Please call the function directly instead.")
        domain.Create([:int])
      end
    end

    context "with libvirt installed" do
      before :each do
        domain.stub(:ffi_lib).with("libvirt")
      end

      context "and the function is a valid one" do
        before :each do
          domain.stub(:attach_function).with("virDomainCreate", "virDomainCreate", [], :int).and_return(true)
          domain.stub(:send).with("virDomainCreate", [])
        end

        after :each do
          domain.Create([:int])
        end

        it "should attach it as a binding for C's function" do
          domain.should_receive(:attach_function).with("virDomainCreate", "virDomainCreate", [], :int).and_return(true)
        end

        it "should call the new attached method" do
          domain.should_receive(:send).with("virDomainCreate", [])
        end
      end

      context "and the function is not a valid one" do
        before :each do
          domain.stub(:attach_function).with("virDomainAbc", "virDomainAbc", [], :int).and_raise(FFI::NotFoundError.new('Abc', 'libvirt'))
        end

        it "should raise an exception" do
          lambda { domain.Abc([:int]) }.should raise_error(Libvirt::Ruby::Exceptions::InvalidFunction)
        end
      end
    end

    context "without libvirt installed" do
      it "should raise an exception" do
        lambda { domain.Abc([:int]) }.should raise_error(Libvirt::Ruby::Exceptions::MissingLib)
      end
    end
  end
end