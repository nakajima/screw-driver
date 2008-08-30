$:.unshift File.dirname(__FILE__)

require 'rubygems'
require 'sinatra'
require 'colored'
require 'screw_driver/suite.rb'
require 'screw_driver/helpers.rb'

configure do
  Rack::CommonLogger.class_eval { def <<(str) end } # Inhibit logging retardase
  SUITE = Screw::Driver::Suite.new(ARGV[0], self)
  brwsr = ARGV[1] || 'Firefox'
  Thread.new { sleep 1; system "open -a #{brwsr} 'http://localhost:4567/?body%20%3E%20.describe'" }
end

SUITE.generate_js_urls
SUITE.generate_css_urls

get('/') { SUITE.send(:doc).to_s }
post('/passed')  { report '.'.green }
post('/failed')  { report 'F'.red, params }
post('/errored') { report 'E'.magenta, params }
post('/before') { before_suite }
post('/after') { after_suite }
post('/exit') { exit_suite }