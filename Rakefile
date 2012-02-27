require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new

desc "Default Task"
task :default => [ :spec ]

rubies = %w(1.8.7@libvirt-ruby 1.9.2@libvirt-ruby 1.9.3@libvirt-ruby)
rubies.each do |ruby|
  desc "Run the test suite against: #{ruby.split('@')[0]}"
  task "spec-#{ruby.split('@')[0]}" do
    puts "Running test suite against: #{ruby.split('@')[0]}"
    exec("rvm #{ruby} do rspec spec")
  end
end