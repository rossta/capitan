require "bundler/gem_tasks"

require 'rspec/core'
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new do |t|
  t.pattern = "./spec/**/*_spec.rb"
end

Dir["#{File.dirname(__FILE__)}/lib/tasks/*"].each { |rake| load rake }

task :default => :spec
