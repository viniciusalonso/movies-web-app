require 'faraday'
require 'pry'
require_relative "../../presenters/movie.rb"

module Services
  module Movie
    class Details

      def initialize base_url, api_key, movie_id
        @base_url = base_url
        @api_key = api_key
        @movie_id = movie_id
      end

      def get
        check_arguments
        endpoint = build_endpoint
        result = Faraday.get endpoint
        parsed = parse_results result

        return instance_presenter parsed if result.status == 200
        nil
      end

      private

      def path
        '/movie'
      end

      def build_endpoint
        "#{@base_url}#{path}/#{@movie_id}?api_key=#{@api_key}&language=en-US"
      end

      def check_arguments
        raise ArgumentError, 'Param missing! Checkout BASE_URL and API_KEY env variables' unless @base_url or @api_key
      end

      def parse_results result
        JSON.parse(result.body)
      end

      def instance_presenter parsed
        ::Presenters::Movie.new parsed
      end
    end
  end
end
