require_relative "../../presenters/movie.rb"
require_relative './base.rb'

module Services
  module Movie
    class Upcoming < Base

      protected

      def path
        '/movie/upcoming'
      end

      def build_endpoint
        "#{@base_url}#{path}?api_key=#{@api_key}&language=en-US&page=1"
      end

      def handle_results
        @parsed_results['results'].map { |movie| ::Presenters::Movie.new(movie) }
      end

    end
  end
end
