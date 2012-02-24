require 'spec_helper'

describe Libvirt::Ruby::Network do
  let(:network) { Libvirt::Ruby::Network }

  context "when calling method #dispatcher" do
    context "with a valid libvirt function" do
      before :each do
        network.stub(:attach_function).with("virNetworkRef", "virNetworkRef", [], :int).and_return(true)
        network.stub(:send).with("virNetworkRef", [])
      end

      after :each do
        network.dispatcher('Ref', [:int])
      end

      it "should attach it as a binding for C's function" do
        network.should_receive(:attach_function).with("virNetworkRef", "virNetworkRef", [], :int).and_return(true)
      end

      it "should call the new attached method" do
        network.should_receive(:send).with("virNetworkRef", [])
      end
    end

    context "with an invalid libvirt function" do
      it "should return an invalid function message" do
        lambda { network.dispatcher('Abc', [:int]) }.should raise_error(Libvirt::Ruby::Exceptions::InvalidFunction)
      end
    end
  end
end