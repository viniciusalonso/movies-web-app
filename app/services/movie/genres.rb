require 'faraday'

module Services
  module Movie
    class Genres

      def initialize base_url, api_key
        @base_url = base_url
        @api_key = api_key
      end

      def get
        check_arguments
        endpoint = build_endpoint
        result = Faraday.get endpoint
        parsed = parse_results result
      end

      private

      def path
        '/genre/movie/list'
      end

      def build_endpoint
        "#{@base_url}#{path}?api_key=#{@api_key}&language=en-US"
      end

      def check_arguments
        raise ArgumentError, 'Param missing! Checkout BASE_URL and API_KEY env variables' unless @base_url or @api_key
      end

      def parse_results result
        JSON.parse(result.body)['genres']
      end

    end
  end
end
