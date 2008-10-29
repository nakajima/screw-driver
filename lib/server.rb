require 'rubygems'
require 'sinatra'
require 'ext/string.rb'
require 'ext/hpricot.rb'
require 'browser.rb'
require 'browsers/firefox.rb'
require 'browsers/safari.rb'
require 'rails.rb'
require 'suite.rb'
require 'helpers.rb'

configure do
  Rack::CommonLogger.class_eval { def <<(str) end } # Inhibit logging retardase
  SUITE = Screw::Driver::Suite.new(self, ARGS)
  SUITE.browser.start
end

SUITE.generate_urls

get('/') { SUITE.to_s }
post('/passed')  { report '.'.green }
post('/failed')  { report 'F'.red, params }
post('/errored') { report 'E'.magenta, params }
post('/before')  { before_suite }
post('/after')   { after_suite }
post('/exit')    { exit_suite unless SUITE.server? }