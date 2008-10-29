SCREW_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..')) unless defined?(SCREW_ROOT)
FIXTURE_PATH = File.expand_path(File.join(File.dirname(__FILE__), 'fixtures')) unless defined?(FIXTURE_PATH)

$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib')
$LOAD_PATH << File.join(File.dirname(__FILE__), '..', 'lib', 'browsers')

require 'rubygems'
require 'spec'
require 'ext/hpricot'
require 'browser'
require 'firefox'
require 'safari'
require 'rails'
require 'suite'

[Screw::Driver::Browser::Safari, Screw::Driver::Browser::Firefox].each do |klass|
  klass.class_eval { def kill; end }
end

module FakeContext
  def routes
    @routes ||= { }
  end
  
  def get(url, &block)
    routes[url] = proc(&block)
  end
end

def create_suite(*addl_opts)
  @context = stub('context')
  @context.extend(FakeContext)
  yield @context if block_given?
  @args = ['spec/fixtures/suite.html']
  addl_opts.each { |opt| @args << opt }
  suite = Screw::Driver::Suite.new(@context, @args)
  suite.stub!(:headers)
  suite
end