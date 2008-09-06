module Screw
  module Driver
    module Rails
      def rails?
        @rails
      end
      
      def rails_urls
        @rails_urls ||= begin
          @public_path = File.join(Dir.pwd, 'public', 'javascripts')
          Dir.new(public_path).entries.inject([]) do |files, entry|
            files << File.expand_path(File.join(public_path, entry)) if entry.match(/\.js$/)
            files
          end
        end
      end
      
      def generate_rails_urls
        rails_urls.each do |url|
          generate "/javascripts/#{File.basename(url)}", 'text/javascript', @public_path
        end
      end
    end
  end
end