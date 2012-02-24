require 'spec_helper'

describe Libvirt::Ruby::Domain do
  let(:domain) { Libvirt::Ruby::Domain }

  context "when calling method #dispatcher" do
    context "with a valid libvirt function" do
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

    context "with an invalid libvirt function" do
      it "should return an invalid function message" do
        lambda { domain.dispatcher('Abc', [:int]) }.should raise_error(Libvirt::Ruby::Exceptions::InvalidFunction)
      end
    end
  end
end