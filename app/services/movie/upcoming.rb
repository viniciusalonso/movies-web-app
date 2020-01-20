require 'faraday'
require_relative "../../presenters/movie.rb"

module Services
  module Movie
    class Upcoming

      def initialize base_url, api_key
        @base_url = base_url
        @api_key = api_key
      end

      def get
        check_arguments
        endpoint = build_endpoint
        result = Faraday.get endpoint
        parsed = parse_results result
        instance_presenters parsed
      end

      private

      def path
        '/movie/upcoming'
      end

      def build_endpoint
        "#{@base_url}#{path}?api_key=#{@api_key}&language=en-US&page=1"
      end

      def check_arguments
        raise ArgumentError, 'Param missing! Checkout BASE_URL and API_KEY env variables' unless @base_url or @api_key
      end

      def parse_results result
        JSON.parse(result.body)['results']
      end

      def instance_presenters movies
        movies.map { |movie| ::Presenters::Movie.new(movie) }
      end

    end
  end
end
