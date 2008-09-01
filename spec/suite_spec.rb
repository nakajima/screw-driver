require File.join(File.dirname(__FILE__), 'spec_helper')

describe Screw::Driver::Suite do
  before(:each) do
    @suite = create_suite
  end
  
  describe "parse_args" do
    it "should get path" do
      @suite.path.should == File.join(FIXTURE_PATH, 'suite.html')
    end

    it "should have server mode" do
      @suite.should_not be_server
      create_suite('--server').should be_server
    end
    
    it "should get browser" do
      create_suite('--browser', 'Safari').browser.should == 'Safari'
    end
    
    it "should default browser to Firefox" do
      @suite.browser.should == 'Firefox'
    end
  end
  
  it "should get working_directory" do
    @suite.working_directory.should == FIXTURE_PATH
  end
  
  it "should find external script_urls" do
    @suite.should have(14).script_urls
  end
  
  it "should find external link_urls" do
    @suite.should have(1).link_urls
  end
  
  it "should generate GET urls for scripts" do
    @stub.should_receive(:get).exactly(14).times
    @suite.generate_js_urls
  end
  
  it "should generate GET urls for links" do
    @stub.should_receive(:get).exactly(1).times
    @suite.generate_css_urls
  end
end