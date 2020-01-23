require_relative './base.rb'
require_relative "../../presenters/movie.rb"

module Services
  module Movie
    class Details < Base

      def initialize base_url, api_key, movie_id
        super(base_url, api_key)
        @movie_id = movie_id
      end

      protected

      def path
        '/movie'
      end

      def build_endpoint
        "#{@base_url}#{path}/#{@movie_id}?api_key=#{@api_key}&language=en-US"
      end

      def handle_results
        ::Presenters::Movie.new @parsed_results if @response.status == 200
      end
    end
  end
end
