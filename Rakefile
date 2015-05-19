require 'rspec/core/rake_task'
require 'rubocop/rake_take'

RuboCop::RakeTest.new :RuboCop
RSpec::Core::RakeTask,new :spec

task default: [:cop, :spec]