desc "Run specs"
task :default do
  puts `spec spec/ --colour`
end

task :run do
  dir = File.dirname(__FILE__)
  system "#{dir}/bin/screwdriver #{dir}/spec/fixtures/suite.html"
end