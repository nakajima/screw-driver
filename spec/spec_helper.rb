FIXTURE_PATH = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures'))

require 'rubygems'
require 'spec'
require File.join(File.dirname(__FILE__), '..', 'lib', 'suite.rb')

def create_suite(*additional_options)
  @stub = stub('context')
  @stub.stub!(:get)
  @args = ['fixtures/suite.html']
  additional_options.each { |opt| @args << opt }
  Screw::Driver::Suite.new(@stub, @args)
end