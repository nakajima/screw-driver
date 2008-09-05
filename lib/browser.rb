module Screw
  module Driver
    module Browser
      LIST = []
      
      def inherited(base)
        LIST << base
      end
    end
  end
end