require 'spec_helper'

describe Libvirt::Ruby::StoragePool do
  let(:storage_pool) { Libvirt::Ruby::StoragePool }

  context "when calling method #dispatcher" do
    context "with libvirt installed" do
      before :each do
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
      it "should raise an exception" do
        lambda { storage_pool.dispatcher('Abc', [], :int) }.should raise_error(Libvirt::Ruby::Exceptions::MissingLib)
      end
    end
  end
end