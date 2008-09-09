module Screw
  module Driver
    class Safari < Browser
      def start
        Thread.new { sleep 1; system "open -a Safari 'http://localhost:4567/?body%20%3E%20.describe'" }
        # t.join
      end
      
      def kill
        osascript('close_safari.scpt') || super
      end
    end
  end
end
