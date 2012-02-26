module Libvirt
  module Ruby
    class Connect < Libvirt::Ruby::Util
      def self.klass
        "virConnect"
      end
    end
  end
end