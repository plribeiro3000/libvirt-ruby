module Libvirt
  module Ruby
    class Domain < Libvirt::Ruby::Util
      def self.klass
        "virDomain"
      end
    end
  end
end