require 'spec_helper'

describe Libvirt::Ruby::Domain do
  let(:domain) { Libvirt::Ruby::Domain }

  context "when calling method #dispatcher" do
    before :each do
      domain.stub(:attach_function).with("virDomainCreate", "virDomainCreate", [], :int).and_return(true)
      domain.stub(:send).with("virDomainCreate", [])
    end

    after :each do
      domain.dispatcher('Create', [:int])
    end

    it "should attach it as a binding for C's function" do
      domain.should_receive(:attach_function).with("virDomainCreate", "virDomainCreate", [], :int).and_return(true)
    end

    it "should call the new attached method" do
      domain.should_receive(:send).with("virDomainCreate", [])
    end
  end
end