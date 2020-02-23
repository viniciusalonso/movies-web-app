require_relative "../../presenters/movie.rb"
require_relative './base.rb'

module Services
  module Movie
    class Search < Base

      def initialize base_url, api_key, query
        super(base_url, api_key)
        @query = query
      end

      protected

      def path
        '/search/movie'
      end

      def build_endpoint
        "#{@base_url}#{path}?api_key=#{@api_key}&language=en-US&page=1&query=#{@query}&include_adult=false"
      end

      def handle_results
        return { movies: [], total_pages: 0 } if @response.status == 422

        if @response.status == 200
          movies = @parsed_results['results'].map { |movie| ::Presenters::Movie.new(movie) }
          { movies: movies, total_pages: @parsed_results['total_pages'] }
        end
      end

    end
  end
end
