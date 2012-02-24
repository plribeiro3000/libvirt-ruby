require 'spec_helper'

describe Libvirt::Ruby::StorageVol do
  let(:storage_vol) { Libvirt::Ruby::StorageVol }

  context "when calling method #dispatcher" do
    context "with a valid libvirt function" do
      before :each do
        storage_vol.stub(:attach_function).with("virStorageVolResize", "virStorageVolResize", [], :int).and_return(true)
        storage_vol.stub(:send).with("virStorageVolResize", [])
      end

      after :each do
        storage_vol.dispatcher('Resize', [:int])
      end

      it "should attach it as a binding for C's function" do
        storage_vol.should_receive(:attach_function).with("virStorageVolResize", "virStorageVolResize", [], :int).and_return(true)
      end

      it "should call the new attached method" do
        storage_vol.should_receive(:send).with("virStorageVolResize", [])
      end
    end

    context "with an invalid libvirt function" do
      it "should return an invalid function message" do
        lambda { storage_vol.dispatcher('Abc', [:int]) }.should raise_error(Libvirt::Ruby::Exceptions::InvalidFunction)
      end
    end
  end
end