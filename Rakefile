require 'rubygems'
require 'rake'

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "pivotal-tracker-console"
    gem.summary = %Q{A console application to Pivotal Tracker}
    gem.description = %Q{A simple console application to interact with Pivotal Tracker}
    gem.email = "leandrodoze@gmail.com"
    gem.homepage = "http://github.com/leandrosilva/pivotal-tracker-console"
    gem.authors = ["Leandro Silva"]
    gem.add_development_dependency "rspec", ">= 1.2.9"
    gem.add_dependency %q<thor>, ">= 0.14.0"
    gem.add_dependency %q<pivotal-tracker>, ">=0.2.0"
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :spec => :check_dependencies

task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "pivotal-tracker-console #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
