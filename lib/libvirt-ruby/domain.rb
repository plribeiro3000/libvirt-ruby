module Libvirt
  module Ruby
    module Domain
      extend Libvirt::Ruby::Util

      def self.klass
        "virDomain"
      end
    end
  end
end