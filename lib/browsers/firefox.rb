module Screw
  module Driver
    module Browser
      class Firefox
        def start
          Thread.new do
            sleep 1
            system "open -a Firefox 'http://localhost:4567/?body%20%3E%20.describe'"
          end
        end
        
        def kill
          puts "   killing Firefox... "
          browser_pid = `ps aux | grep -v grep | grep Firefox.app`.scan(/\d+/).first
          `kill -s SIGTERM #{browser_pid}`
          puts '   done.'
        end
      end
    end
  end
end