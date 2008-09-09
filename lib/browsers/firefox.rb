module Screw
  module Driver
    class Firefox < Browser
      def start
        Thread.new do
          sleep 1
          system "open -a Firefox 'http://localhost:4567/?body%20%3E%20.describe'"
        end
      end
      
      def kill
        osascript('close_firefox.scpt') || super
      end
    end
  end
end