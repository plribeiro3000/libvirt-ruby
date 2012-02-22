require 'spec_helper'

describe Libvirt::Ruby::Connect do
  let(:connect) { Libvirt::Ruby::Connect }

  context "when calling method #dispatcher" do
    before :each do
      connect.stub(:attach_function).with("virConnectClose", "virConnectClose", [], :int).and_return(true)
      connect.stub(:send).with("virConnectClose", [])
    end

    after :each do
      connect.dispatcher('Close', [:int])
    end

    it "should attach it as a binding for C's function" do
      connect.should_receive(:attach_function).with("virConnectClose", "virConnectClose", [], :int).and_return(true)
    end

    it "should call the new attached method" do
      connect.should_receive(:send).with("virConnectClose", [])
    end
  end
end