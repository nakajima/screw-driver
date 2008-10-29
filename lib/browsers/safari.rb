module Screw
  module Driver
    module Browser
      class Safari
        def start
          Thread.new { sleep 1; system "open -n -a Safari 'http://localhost:4567/?body%20%3E%20.describe'" }
          # t.join
        end
        
        def kill
          puts "   killing Safari... "
          browser_pid = `ps aux | grep -v grep | grep Safari.app`.scan(/\d+/).first
          system("kill -s SIGTERM #{browser_pid}")
          puts '   done.'
        end
      end
    end
  end
end
