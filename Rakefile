require 'rubygems'
require 'rake/rdoctask'
require 'rake/packagetask'
require 'rake/gempackagetask'
require 'rake/testtask'
require 'rake/contrib/rubyforgepublisher'


begin
  require 'jeweler'
  Jeweler::Tasks.new do |s|
    s.name = "bolide_client"
    s.version = "0.0.1"
    s.author = "Julien Guimont"
    s.email = "julien.guimont@gmail.com"
    s.homepage = "http://github.com/juggy/bolide-client"
    s.platform = Gem::Platform::RUBY
    s.summary = "Ruby client for Bolide API"
    s.files = FileList["{bin,lib}/**/*"].to_a
    s.require_path = "lib"
    s.has_rdoc = false
    s.extra_rdoc_files = ["README"]
    s.add_dependency("patron", ">= 0.4.4")
    s.add_dependency("nokogiri", ">= 1.4.1")
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler not available. Install it for jeweler-related tasks with: sudo gem install jeweler"
end

spec = Gem::Specification.new do |s| 
  s.name = "bolide_client"
  s.version = "0.0.1"
  s.author = "Julien Guimont"
  s.email = "julien.guimont@gmail.com"
  s.homepage = "http://github/juggy"
  s.platform = Gem::Platform::RUBY
  s.summary = "Ruby client for Bolide API"
  s.files = FileList["{bin,lib}/**/*"].to_a
  s.require_path = "lib"
  s.has_rdoc = false
  s.extra_rdoc_files = ["README"]
  s.add_dependency("patron", ">= 0.4.4")
  s.add_dependency("nokogiri", ">= 1.4.1")
end
 
Rake::GemPackageTask.new(spec) do |pkg| 
  pkg.need_tar = true 
end

Rake::RDocTask.new do |rd|
  rd.main = "README.rdoc"
  rd.rdoc_files.include("README.rdoc", "FAQ.rdoc", "History.rdoc", "lib/bolide.rb")
  rd.rdoc_dir = 'doc'
end