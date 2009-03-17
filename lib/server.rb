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

class Runner < Sinatra::Base
  include Helpers
  
  class << self; attr_accessor :suite end
  
  configure do
    Rack::CommonLogger.class_eval { def <<(str) end } # Inhibit logging retardase
    self.suite = Screw::Driver::Suite.new(self, ARGS)
    self.suite.browser.start
  end

  suite.generate_urls

  get('/') { Runner.suite.to_s }
  post('/passed')  { report '.'.green }
  post('/failed')  { report 'F'.red, params }
  post('/errored') { report 'E'.magenta, params }
  post('/before')  { before_suite }
  post('/after')   { after_suite }
  post('/exit')    { exit_suite unless Runner.suite.server? }
end

Runner.run!