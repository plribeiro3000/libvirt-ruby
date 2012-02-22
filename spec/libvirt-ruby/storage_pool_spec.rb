require 'spec_helper'

describe Libvirt::Ruby::StoragePool do
  context "on initialization" do
    it "should set @klass" do
      Libvirt::Ruby::StoragePool.new.klass.should == 'virStoragePool'
    end
  end

  context "on a non existent method" do
    it "should concat it to @klass" do
      Libvirt::Ruby::StoragePool.new.ptr.klass.should == 'virStoragePoolPtr'
    end

    it "should return self" do
      obj = Libvirt::Ruby::StoragePool.new
      obj.ptr.should == obj
    end
  end

  context "with 2 methods not existent chained" do
    it "should concat both to @klass" do
      Libvirt::Ruby::StoragePool.new.get.autostart.klass.should == 'virStoragePoolGetAutostart'
    end

    it "should return self" do
      obj = Libvirt::Ruby::StoragePool.new
      obj.get.autostart.should == obj
    end
  end
end