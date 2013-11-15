require "bundler/gem_tasks"

require 'rspec/core/rake_task'

desc "Run tests with SimpleCov"
task :spec do |t|
  RSpec::Core::RakeTask.new(:cov) do |t|
    ENV["COVERAGE"] = "1"
  end
end

RSpec::Core::RakeTask.new(:spec)
task :default => :spec

desc "Alias for 'rake spec'"
task :test => [:spec]