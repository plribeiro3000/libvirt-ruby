require 'spec_helper'

describe Libvirt::Ruby::StoragePool do
  let(:storage_pool) { Libvirt::Ruby::StoragePool }

  context "when calling method #dispatcher" do
    context "that is now deprecated" do
      before :each do
        storage_pool.stub(:ffi_lib).with("libvirt")
        storage_pool.stub(:attach_function).with("virStoragePoolRefresh", "virStoragePoolRefresh", [], :int)
        storage_pool.stub(:send).with("virStoragePoolRefresh", [])
      end

      it "should raise a deprecated method warning" do
        storage_pool.should_receive(:warn).with("[DEPRECATION] `dispatcher` is deprecated.  Please call the function directly instead.")
        storage_pool.dispatcher('Refresh', [], :int)
      end
    end

    context "with libvirt installed" do
      before :each do
        storage_pool.stub(:warn).with("[DEPRECATION] `dispatcher` is deprecated.  Please call the function directly instead.")
        storage_pool.stub(:ffi_lib).with("libvirt")
      end

      context "and a valid libvirt function" do
        before :each do
          storage_pool.stub(:attach_function).with("virStoragePoolRefresh", "virStoragePoolRefresh", [], :int).and_return(true)
          storage_pool.stub(:send).with("virStoragePoolRefresh", [])
        end

        after :each do
          storage_pool.dispatcher('Refresh', [], :int)
        end

        it "should attach it as a binding for C's function" do
          storage_pool.should_receive(:attach_function).with("virStoragePoolRefresh", "virStoragePoolRefresh", [], :int).and_return(true)
        end

        it "should call the new attached method" do
          storage_pool.should_receive(:send).with("virStoragePoolRefresh", [])
        end
      end

      context "and an invalid libvirt function" do
        before :each do
          storage_pool.stub(:attach_function).with("virStoragePoolAbc", "virStoragePoolAbc", [], :int).and_raise(FFI::NotFoundError.new('Abc', 'libvirt'))
        end

        it "should raise an exception" do
          lambda { storage_pool.dispatcher('Abc', [], :int) }.should raise_error(Libvirt::Ruby::Exceptions::InvalidFunction)
        end
      end
    end

    context "without libvirt installed" do
      before :each do
        storage_pool.stub(:warn).with("[DEPRECATION] `dispatcher` is deprecated.  Please call the function directly instead.")
      end

      it "should raise an exception" do
        lambda { storage_pool.dispatcher('Abc', [], :int) }.should raise_error(Libvirt::Ruby::Exceptions::MissingLib)
      end
    end
  end

  context "when calling any libvirt function directly" do
    context "that is the new way" do
      before :each do
        storage_pool.stub(:ffi_lib).with("libvirt")
        storage_pool.stub(:attach_function).with("virStoragePoolRefresh", "virStoragePoolRefresh", [], :int)
        storage_pool.stub(:send).with("virStoragePoolRefresh", [])
      end

      it "should  not raise a deprecated method warning" do
        storage_pool.should_not_receive(:warn).with("[DEPRECATION] `dispatcher` is deprecated.  Please call the function directly instead.")
        storage_pool.Refresh([:int])
      end
    end

    context "with libvirt installed" do
      before :each do
        storage_pool.stub(:ffi_lib).with("libvirt")
      end

      context "and the function is a valid one" do
        before :each do
          storage_pool.stub(:attach_function).with("virStoragePoolRefresh", "virStoragePoolRefresh", [], :int).and_return(true)
          storage_pool.stub(:send).with("virStoragePoolRefresh", [])
        end

        after :each do
          storage_pool.Refresh([:int])
        end

        it "should attach it as a binding for C's function" do
          storage_pool.should_receive(:attach_function).with("virStoragePoolRefresh", "virStoragePoolRefresh", [], :int).and_return(true)
        end

        it "should call the new attached method" do
          storage_pool.should_receive(:send).with("virStoragePoolRefresh", [])
        end
      end

      context "and the function is not a valid one" do
        before :each do
          storage_pool.stub(:attach_function).with("virStoragePoolAbc", "virStoragePoolAbc", [], :int).and_raise(FFI::NotFoundError.new('Abc', 'libvirt'))
        end

        it "should raise an exception" do
          lambda { storage_pool.Abc([:int]) }.should raise_error(Libvirt::Ruby::Exceptions::InvalidFunction)
        end
      end
    end

    context "without libvirt installed" do
      it "should raise an exception" do
        lambda { storage_pool.Abc([:int]) }.should raise_error(Libvirt::Ruby::Exceptions::MissingLib)
      end
    end
  end
end