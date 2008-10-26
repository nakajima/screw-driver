require File.join(File.dirname(__FILE__), 'spec_helper')

describe Screw::Driver::Rails do
  before(:each) do
    Dir.stub!(:pwd).and_return(FIXTURE_PATH)
  end
  
  it "should break" do
    true.should be_false
  end
  
  it "can be railsy" do
    suite = create_suite '--rails'
    suite.should be_rails
  end
  
  it "should find rails js files" do
    suite = create_suite '--rails'
    suite.rails_urls.length.should == 2
    suite.rails_urls.should include(File.expand_path(File.join(FIXTURE_PATH, 'public', 'javascripts', 'application.js')))
    suite.rails_urls.should include(File.expand_path(File.join(FIXTURE_PATH, 'public', 'javascripts', 'lib.js')))
  end

  it "should serve rails javascripts" do
    suite = create_suite do |context|
      context.should_receive(:get).with('/javascripts/application.js')
      context.should_receive(:get).with('/javascripts/lib.js')
    end
    
    suite.generate_rails_urls
  end
end