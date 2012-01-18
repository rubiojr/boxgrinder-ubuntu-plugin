# encoding: utf-8

require 'rubygems'
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.version = '0.2.3'
  gem.name = "boxgrinder-ubuntu-plugin"
  gem.homepage = "http://github.com/rubiojr/boxgrinder-ubuntu-plugin"
  gem.license = "MIT"
  gem.summary = %Q{Ubuntu OS boxgrinder plugin}
  gem.description = %Q{Ubuntu OS boxgrinder plugin}
  gem.email = "rubiojr@frameos.org"
  gem.authors = ["Sergio Rubio"]
  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rake/testtask'
Rake::TestTask.new(:test) do |test|
  test.libs << 'lib' << 'test'
  test.pattern = 'test/**/test_*.rb'
  test.verbose = true
end

task :default => :build

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "boxgrinder-ubuntu-plugin #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
