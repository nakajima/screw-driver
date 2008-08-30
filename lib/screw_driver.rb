$:.unshift File.dirname(__FILE__)

require 'rubygems'
require 'sinatra'
require 'colored'
require 'screw_driver/suite.rb'
require 'screw_driver/helpers.rb'

configure do
  Rack::CommonLogger.class_eval { def <<(str) end } # Inhibit logging retardase
  SUITE = Screw::Driver::Suite.new(ARGV[0], self)
  browser = ARGV[1] || 'Firefox'
  Thread.new { sleep 1; system "open -a #{browser} 'http://localhost:4567/?body%20%3E%20.describe'" }
end

post('/passed')  { report '.'.green }
post('/failed')  { report 'F'.red, params }
post('/errored') { report 'E'.magenta, params }

SUITE.generate_js_urls
SUITE.generate_css_urls

get '/' do
  SUITE.send(:doc).to_s
end

post '/before' do
  padded do
    puts "Staring to run test suite..."
  end
end

post '/after' do
  padded do
    SUITE.failures.each do |failure|
      padded do
        puts "FAILURE".red
        puts "- #{failure[:name]}: #{failure[:reason]}"
      end
    end
    print "Finished. #{SUITE.test_count} tests. "
    print "#{SUITE.failures.length} failures." unless SUITE.failures.empty?
  end
end

post '/exit' do
  $stdout.print "== Spec Server "
  $stdout.flush
  pid = `ps aux | grep #{File.basename(__FILE__)} | grr --column 2`
  `kill #{pid}`
end