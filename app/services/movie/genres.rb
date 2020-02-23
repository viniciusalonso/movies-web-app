require_relative './base.rb'

module Services
  module Movie
    class Genres < Base

      protected

      def path
        '/genre/movie/list'
      end

      def handle_results
        @parsed_results['genres']
      end

    end
  end
end
