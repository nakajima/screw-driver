$:.unshift File.dirname(__FILE__)

require 'rubygems'
require 'hpricot'
require 'sinatra'
require 'colored'
require 'screw_driver/suite.rb'
require 'screw_driver/helpers.rb'

configure do
  Rack::CommonLogger.class_eval { def <<(str) end } # Inhibit logging retardase
  SUITE = Screw::Driver::Suite.new(ARGV[0], self)
  Thread.new { sleep 1; system "open -a Firefox 'http://localhost:4567/?body%20%3E%20.describe'" }
end

post('/passed') { report '.'.green }
post('/failed') { report 'F'.red, params }
post('/errored') { report 'E'.magenta, params }

SUITE.generate_js_urls
SUITE.generate_css_urls

get '/' do
  SUITE.send(:doc).to_s
end

post '/before' do
  puts
  puts "Staring to run test suite..."
  puts
  :ok
end

post '/after' do
  puts "\n\n"
  SUITE.failures.each do |failure|
    puts ""
    puts "FAILURE".red
    puts "- #{failure[:name]}: #{failure[:reason]}"
    puts ""
  end
  print "Finished. #{SUITE.test_count} tests. "
  print "#{SUITE.failures.length} failures." unless SUITE.failures.empty?
  puts ""
  :ok
end

post '/exit' do
  $stdout.print "== Spec Server "
  $stdout.flush
  pid = `ps aux | grep #{File.basename(__FILE__)} | grr --column 2`
  `kill #{pid}`
end