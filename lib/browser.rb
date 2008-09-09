module Screw
  module Driver
    class Browser
      def kill
        name = self.class.name.split('::').last
        puts "   killing #{name}... "
        browser_pid = `ps aux | grep -v grep | grep #{name}.app`.scan(/\d+/).first
        `kill -s SIGTERM #{browser_pid}`
        puts '   done.'
      end
      
      def osascript(name)
        dir = File.expand_path(File.dirname(__FILE__) + '/browsers/applescripts')
        system("osascript #{dir}/#{name}") rescue false
      end
    end
  end
end