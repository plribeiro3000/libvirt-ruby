module Libvirt
  module Ruby
    class Network < Libvirt::Ruby::Util
      def self.klass
        "virNetwork"
      end
    end
  end
end