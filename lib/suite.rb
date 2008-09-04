require 'hpricot'

module Screw
  module Driver
    class Suite
      attr_reader :failures, :test_count, :path
      
      def initialize(context, args)
        @args, @context = args, context
        parse_args and reset!
      end
      
      def passed!
        @test_count += 1
      end
      
      def failed!(result)
        @test_count += 1
        @failures << result
      end
      
      def reset!
        @test_count = 0
        @failures = []
      end
      
      def working_directory
        File.dirname(@path)
      end
      
      def generate_js_urls
        script_urls.each { |url| generate(url, "text/javascript") }
      end
      
      def generate_css_urls
        link_urls.each { |url| generate(url, "text/css") }
      end
      
      def script_urls
        doc.search('script').map { |script| script['src'] }.compact
      end
      
      def link_urls
        doc.search('link').map { |script| script['href'] }.compact
      end
      
      def to_s
        doc.to_s
      end
      
      def browser
        @browser || 'Firefox'
      end
      
      def server?
        @server
      end
      
      def exit
        exit! failures.empty? ? 0 : 1
      end
      
      private
      
      def generate(url, content_type, prefix=working_directory)
        path = prefix + url
        @context.send(:get, url) do
          headers 'Content-Type' => content_type
          File.read(path)
        end
      end
      
      def parse_args
        @server = @args.delete('--server') ? true : false
        
        if (i = @args.index('--browser'))
          @browser = @args[i+1]
          @args.delete('--browser')
          @args.delete(@browser)
        end
          
        @path = File.join(Dir.pwd, @args.shift)
      end
      
      def doc
        Hpricot(File.open(@path))
      end
    end
  end
end