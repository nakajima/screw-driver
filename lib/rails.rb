module Screw
  module Driver
    module Rails
      def rails?
        @rails
      end

      def rails_urls
        @rails_urls ||= Dir[File.join(public_path, "**", "*.js")]
      end

      def generate_rails_urls
        rails_urls.each do |url|
          generate "/javascripts/#{File.basename(url)}", 'text/javascript', public_path
        end
      end

    private

      def public_path
        @public_path ||= File.join(Dir.pwd, 'public', 'javascripts')
      end
    end
  end
end