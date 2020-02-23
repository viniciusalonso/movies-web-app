module Helpers
  class Pagination

    def initialize range, url
      @range = range
      @url = url
    end

    def paginate
      @range.to_a.map { |page| "#{@url}?page=#{page}" }
    end
  end
end
