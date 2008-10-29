require 'rubygems'
require 'sinatra'
require 'sinatra/test/rspec'

ARGS = ['--load-paths', 'spec/fixtures/src', 'spec/fixtures/suite.html']

require File.join(File.dirname(__FILE__), 'spec_helper')
require 'server'

describe Screw::Driver do
  attr_reader :response
  
  it "serves the suite" do
    get_it '/'
    response.should be_ok
  end
  
  it "inserts the base tag" do
    get_it '/'
    response.body.should include("<base")
  end
  
  it "gets a js file" do
    get_it '/bar.js'
    response.body.should == "var bar = { foo: true }"
  end
  
  it "gets a nested js file" do
    get_it '/great.js'
    response.body.should == "var Great = { terrific: true }"
  end
  
  describe "test result handlers" do
    it "adds a passing test" do
      SUITE.should_receive(:write_dot!)
      proc {
        post_it '/passed'
      }.should change(SUITE, :test_count)
    end
  end
end
