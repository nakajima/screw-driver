require 'hpricot'
module Screw
  module Driver
    class Suite
      attr_reader :failures, :test_count
      
      def initialize(path, context)
        raise "No suite found: #{path}" unless File.exists?(path)
        @path = path
        @context = context
        @test_count = 0
        @failures = []
        generate_js_urls
        generate_css_urls
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
        doc.search('script').map { |script| script['src'] }
      end
      
      def link_urls
        doc.search('link').map { |script| script['href'] }
      end
      
      private
      
      def generate(url, content_type)
        path = working_directory + url
        @context.send(:get, url) do
          headers 'Content-Type' => content_type
          File.read(path)
        end
      end
      
      def doc
        @doc ||= Hpricot(File.open(@path))
      end
    end
  end
end