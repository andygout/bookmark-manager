require 'rspec/core/rake_task'
require 'rubocop/rake_take'
require 'data_mapper'
require 'server'

RuboCop::RakeTest.new :RuboCop
RSpec::Core::RakeTask.new :spec

task default: [:cop, :spec]

task :auto_upgrade do
  DataMapper.auto_upgrade!
  puts 'Auto-upgrade complete (no data loss)'
end

task :auto_migrate do
  DataMapper.auto_migrate!
  puts 'Auto-migrate complete (data could have been lost)'
end
