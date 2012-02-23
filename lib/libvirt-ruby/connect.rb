module Libvirt
  module Ruby
    module Connect
      extend Libvirt::Ruby::Util

      def self.klass
        "virConnect"
      end
    end
  end
end