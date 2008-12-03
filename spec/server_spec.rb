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
    Hpricot(response.body).at('base').should_not be_nil
  end
  
  it "gets a js file" do
    get_it '/bar.js'
    response.body.should == "var bar = { foo: true }"
  end
  
  it "gets a nested js file" do
    get_it '/src/great.js'
    response.body.should == "var Great = { terrific: true }"
  end
  
  it "gets a fixture" do
    get_it '/fixtures/tags.html'
    response.body.should == '<div class="tags"></div>'
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
