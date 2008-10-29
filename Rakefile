require 'spec/rake/spectask'

task :default => [:spec]

desc "Run all specs"
Spec::Rake::SpecTask.new('spec') do |t|
  t.spec_files = FileList['spec/**/*.rb']
end

task :run do
  dir = File.dirname(__FILE__)
  system "#{dir}/bin/screwdriver #{dir}/spec/fixtures/suite.html"
end