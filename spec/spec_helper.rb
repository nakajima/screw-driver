SCREW_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..'))
FIXTURE_PATH = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures'))

require 'rubygems'
require 'spec'
require File.join(File.dirname(__FILE__), '..', 'lib', 'browser.rb')
require File.join(File.dirname(__FILE__), '..', 'lib', 'browsers', 'firefox.rb')
require File.join(File.dirname(__FILE__), '..', 'lib', 'browsers', 'safari.rb')
require File.join(File.dirname(__FILE__), '..', 'lib', 'suite.rb')

[Screw::Driver::Browser::Safari, Screw::Driver::Browser::Firefox].each do |klass|
  klass.class_eval { def kill; end }
end

def create_suite(*additional_options)
  @stub = stub('context')
  @stub.stub!(:get)
  @args = ['spec/fixtures/suite.html']
  additional_options.each { |opt| @args << opt }
  Screw::Driver::Suite.new(@stub, @args)
end