require_relative "../../presenters/movie.rb"
require_relative './base.rb'

module Services
  module Movie
    class Upcoming < Base

      def initialize base_url, api_key, page = 1
        super(base_url, api_key)
        @page = page
      end

      protected

      def path
        '/movie/upcoming'
      end

      def build_endpoint
        "#{@base_url}#{path}?api_key=#{@api_key}&language=en-US&page=#{@page}"
      end

      def handle_results
        movies = @parsed_results['results'].map { |movie| ::Presenters::Movie.new(movie) }
        { 'movies': movies, 'total_pages': @parsed_results['total_pages'] }
      end

    end
  end
end
