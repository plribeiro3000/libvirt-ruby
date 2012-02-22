require "rubygems"
require "rspec"

Dir.glob(File.dirname(__FILE__) + "/../lib/libvirt-ruby/**/*.rb").each { |file| require file }