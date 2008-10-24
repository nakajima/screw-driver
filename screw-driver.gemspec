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
  s.files = ["README", "Rakefile", "bin/screwdriver", "lib/browser.rb", "lib/browsers/firefox.rb", "lib/browsers/safari.rb", "lib/ext/string.rb", "lib/helpers.rb", "lib/rails.rb", "lib/suite.rb", "js/jquery.ajax_queue.js", "js/screw.driver.js", "spec/browser_spec.rb", "spec/fixtures/bar.js", "spec/fixtures/bar_spec.js", "spec/fixtures/foo.js", "spec/fixtures/foo_spec.js", "spec/fixtures/jquery.ajax_queue.js", "spec/fixtures/public/javascripts/application.js", "spec/fixtures/public/javascripts/lib.js", "spec/fixtures/screw-unit/jquery-1.2.6.js", "spec/fixtures/screw-unit/jquery.fn.js", "spec/fixtures/screw-unit/jquery.print.js", "spec/fixtures/screw-unit/screw.assets.js", "spec/fixtures/screw-unit/screw.behaviors.js", "spec/fixtures/screw-unit/screw.builder.js", "spec/fixtures/screw-unit/screw.css", "spec/fixtures/screw-unit/screw.events.js", "spec/fixtures/screw-unit/screw.matchers.js", "spec/fixtures/screw-unit/screw.server.js", "spec/fixtures/screw.driver.js", "spec/fixtures/spec_helper.js", "spec/fixtures/src/great.js", "spec/fixtures/suite.html", "spec/rails_spec.rb", "spec/spec_helper.rb", "spec/suite_spec.rb"]
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
