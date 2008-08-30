require File.join(File.dirname(__FILE__), 'spec_helper')

describe Screw::Driver::Suite do
  before(:each) do
    @stub = stub('context')
    @suite = Screw::Driver::Suite.new(File.join(FIXTURE_PATH, 'suite.html'), @stub)
  end
  
  it "should get working_directory" do
    @suite.working_directory.should == FIXTURE_PATH
  end
  
  it "should find external script_urls" do
    @suite.should have(12).script_urls
  end
  
  it "should find external link_urls" do
    @suite.should have(1).link_urls
  end
  
  it "should generate GET urls for scripts" do
    @stub.should_receive(:get).exactly(12).times
    @suite.generate_js_urls
  end
  
  it "should generate GET urls for links" do
    @stub.should_receive(:get).exactly(1).times
    @suite.generate_css_urls
  end
end