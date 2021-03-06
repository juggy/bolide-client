# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{bolide_client}
  s.version = "0.0.3"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Julien Guimont"]
  s.date = %q{2010-03-16}
  s.email = %q{julien.guimont@gmail.com}
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    "lib/bolide/account.rb",
     "lib/bolide/q.rb",
     "lib/bolide_client.rb"
  ]
  s.homepage = %q{http://github.com/juggy/bolide-client}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{Ruby client for Bolide API}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<patron>, [">= 0.4.4"])
      s.add_runtime_dependency(%q<nokogiri>, [">= 1.4.1"])
    else
      s.add_dependency(%q<patron>, [">= 0.4.4"])
      s.add_dependency(%q<nokogiri>, [">= 1.4.1"])
    end
  else
    s.add_dependency(%q<patron>, [">= 0.4.4"])
    s.add_dependency(%q<nokogiri>, [">= 1.4.1"])
  end
end

