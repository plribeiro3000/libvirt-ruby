require 'spec_helper'

describe Libvirt::Ruby::Network do
  let(:network) { Libvirt::Ruby::Network }

  context "when calling method #dispatcher" do
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
end