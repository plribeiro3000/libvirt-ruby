require 'spec_helper'

describe Libvirt::Ruby::Domain do
  context "on initialization" do
    it "should set @klass" do
      Libvirt::Ruby::Domain.new.klass.should == 'virDomain'
    end
  end

  context "on a non existent method" do
    it "should concat it to @klass" do
      Libvirt::Ruby::Domain.new.ptr.klass.should == 'virDomainPtr'
    end

    it "should return self" do
      obj = Libvirt::Ruby::Domain.new
      obj.ptr.should == obj
    end
  end

  context "with 2 methods not existent chained" do
    it "should concat both to @klass" do
      Libvirt::Ruby::Domain.new.block.stats.klass.should == 'virDomainBlockStats'
    end

    it "should return self" do
      obj = Libvirt::Ruby::Domain.new
      obj.block.stats.should == obj
    end
  end
end