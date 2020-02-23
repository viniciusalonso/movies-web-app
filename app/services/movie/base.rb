require 'faraday'

module Services
  module Movie
    class Base

      def initialize base_url, api_key
        @base_url = base_url
        @api_key = api_key
      end

      def get
        check_arguments
        @endpoint = build_endpoint
        @response = get_response_from_api
        @parsed_results = parse_results
        handle_results
      end

      protected

      def path; end

      def build_endpoint
        "#{@base_url}#{path}?api_key=#{@api_key}&language=en-US"
      end

      def check_arguments
        raise ArgumentError, 'Param missing! Checkout BASE_URL and API_KEY env variables' unless @base_url or @api_key
      end

      def parse_results
        JSON.parse(@response.body)
      end

      def get_response_from_api
        Faraday.get @endpoint
      end

      def handle_results
        nil
      end

    end
  end
end
