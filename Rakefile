require "bundler/gem_tasks"

require 'rspec/core/rake_task'
require 'rdoc/task'

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

# Generate the RDoc documentation
desc "Create documentation"
Rake::RDocTask.new("doc") do |rdoc|
  rdoc.title = "pdf-reader-markup"
  rdoc.rdoc_dir = "doc"
  rdoc.rdoc_files.include('README.md')
  rdoc.main = 'README.md'
  rdoc.rdoc_files.include('LICENSE.txt')
  rdoc.rdoc_files.include('lib/pdf/reader/*.rb')
  rdoc.rdoc_files.include('lib/pdf/reader/markup/*.rb')
  rdoc.options << "--main"
end