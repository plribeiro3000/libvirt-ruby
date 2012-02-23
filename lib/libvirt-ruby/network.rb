module Libvirt
  module Ruby
    module Network
      extend Libvirt::Ruby::Util

      def self.klass
        "virNetwork"
      end
    end
  end
end