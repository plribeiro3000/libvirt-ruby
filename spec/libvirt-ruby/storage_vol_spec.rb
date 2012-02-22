require 'spec_helper'

describe Libvirt::Ruby::StorageVol do
  context "on initialization" do
    it "should set @klass" do
      Libvirt::Ruby::StorageVol.new.klass.should == 'virStorageVol'
    end
  end

  context "on a non existent method" do
    it "should concat it to @klass" do
      Libvirt::Ruby::StorageVol.new.ptr.klass.should == 'virStorageVolPtr'
    end

    it "should return self" do
      obj = Libvirt::Ruby::StorageVol.new
      obj.ptr.should == obj
    end
  end

  context "with 2 methods not existent chained" do
    it "should concat both to @klass" do
      Libvirt::Ruby::StorageVol.new.wipe.pattern.klass.should == 'virStorageVolWipePattern'
    end

    it "should return self" do
      obj = Libvirt::Ruby::StorageVol.new
      obj.wipe.pattern.should == obj
    end
  end
end