module Helpers
  def padded(spaces=1)
    spaces.times { puts "" }
    yield
    spaces.times { puts "" }
    :ok
  end
  
  def report(str, params=nil)
    params ? Runner.suite.failed!(params) : Runner.suite.passed!
    Runner.suite.write_dot!(str)
    sleep 0.1
    :ok
  end
  
  def before_suite
    Runner.suite.reset!
    padded do
      puts "Staring to run test suite..."
    end
  end
  
  def after_suite
    padded do
      Runner.suite.failures.each do |failure|
        padded do
          puts "Failure:".red
          puts "- #{failure[:name]}: #{failure[:reason]}"
        end
      end
      print "Finished. #{Runner.suite.test_count} tests. "
      print "#{Runner.suite.failures.length} failures." unless Runner.suite.failures.empty?
    end
  end
  
  def exit_suite
    padded do
      puts "== Spec Server Exiting..."
      Runner.suite.exit
    end
  end
end