require File.join(File.dirname(__FILE__), 'spec_helper')

describe Screw::Driver::Suite do
  before(:each) do
    Dir.stub!(:pwd).and_return(SCREW_ROOT) # Simulate running from command line
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
      create_suite('--browser', 'Safari').browser.kind_of?(Screw::Driver::Safari).should be_true
    end
    
    it "should default browser to Firefox" do
      @suite.browser.kind_of?(Screw::Driver::Firefox).should be_true
    end
  end
  
  it "should get working_directory" do
    @suite.working_directory.should == FIXTURE_PATH
  end
  
  it "should find external script_urls" do
    @suite.should have(15).script_urls
  end
  
  it "should find external link_urls" do
    @suite.should have(1).link_urls
  end
  
  it "should generate GET urls" do
    @suite.generate_urls
    @context.routes.should have(16).keys
  end
  
  it "should exit with 0 failures" do
    @suite.should_receive(:exit!).with(0)
    @suite.exit
  end
  
  it "should exit with 1 for failures" do
    @suite.should_receive(:exit!).with(1)
    @suite.failed! :oops
    @suite.exit
  end
  
  it "should exit with 1 for multiple failures" do
    @suite.should_receive(:exit!).with(1)
    @suite.failed! :oops
    @suite.failed! :again
    @suite.exit
  end
  
  describe "load paths" do
    it "should have 1 load_path by default" do
      @suite.should have(2).load_paths
    end
    
    it "should append load paths" do
      suite = create_suite '--load-paths', 'src'
      suite.should have(3).load_paths
    end

    it "should serve files from added load paths directory" do
      suite = create_suite '--load-paths', 'spec/fixtures/src'
      suite.generate_urls
      suite.context.routes['/great.js'].call.should == 'var Great = { terrific: true }'
    end
  end
  
end