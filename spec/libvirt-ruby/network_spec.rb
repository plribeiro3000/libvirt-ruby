require 'spec_helper'

describe Libvirt::Ruby::Network do
  context "on initialization" do
    it "should set @klass" do
      Libvirt::Ruby::Network.new.klass.should == 'virNetwork'
    end
  end

  context "on a non existent method" do
    it "should concat it to @klass" do
      Libvirt::Ruby::Network.new.ptr.klass.should == 'virNetworkPtr'
    end

    it "should return self" do
      obj = Libvirt::Ruby::Network.new
      obj.ptr.should == obj
    end
  end

  context "with 2 methods not existent chained" do
    it "should concat both to @klass" do
      Libvirt::Ruby::Network.new.device.ref.klass.should == 'virNetworkDeviceRef'
    end

    it "should return self" do
      obj = Libvirt::Ruby::Network.new
      obj.device.ref.should == obj
    end
  end
end