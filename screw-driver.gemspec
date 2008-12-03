# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{screw-driver}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Pat Nakajima"]
  s.date = %q{2008-10-23}
  s.default_executable = %q{screwdriver}
  s.email = %q{patnakajima@gmail.com}
  s.executables = ["screwdriver"]
  s.files = [
    "README.textile",
    "Rakefile",
    "bin/screwdriver",
    "lib/browser.rb",
    "lib/browsers/firefox.rb",
    "lib/browsers/safari.rb",
    "lib/ext/string.rb",
    "lib/ext/hpricot.rb",
    "lib/helpers.rb",
    "lib/rails.rb",
    "lib/suite.rb",
    "lib/server.rb",
    "js/jquery.ajax_queue.js",
    "js/screw.driver.js"
  ]
  s.homepage = %q{http://github.com/nakajima/screw-driver}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.0}
  s.summary = %q{Run your Screw.Unit specs from the command line.}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sinatra>, [">= 0"])
      s.add_runtime_dependency(%q<hpricot>, [">= 0"])
    else
      s.add_dependency(%q<sinatra>, [">= 0"])
      s.add_dependency(%q<hpricot>, [">= 0"])
    end
  else
    s.add_dependency(%q<sinatra>, [">= 0"])
    s.add_dependency(%q<hpricot>, [">= 0"])
  end
end
