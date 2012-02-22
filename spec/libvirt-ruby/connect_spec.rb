require 'spec_helper'

describe Libvirt::Ruby::Connect do
  context "on initialization" do
    it "should set @klass" do
      Libvirt::Ruby::Connect.new.klass.should == 'virConnect'
    end
  end

  context "on a non existent method" do
    it "should concat it to @klass" do
      Libvirt::Ruby::Connect.new.ptr.klass.should == 'virConnectPtr'
    end

    it "should return self" do
      obj = Libvirt::Ruby::Connect.new
      obj.ptr.should == obj
    end
  end

  context "with 2 methods not existent chained" do
    it "should concat both to @klass" do
      Libvirt::Ruby::Connect.new.domain.event.klass.should == 'virConnectDomainEvent'
    end

    it "should return self" do
      obj = Libvirt::Ruby::Connect.new
      obj.domain.event.should == obj
    end
  end
end