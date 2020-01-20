module Presenters
  class Movie

    attr_reader :title

    def initialize data
      @title = data['title']
      @release_date = data['release_date']
      @poster_path = data['poster_path']
    end

    def release_date
      date = @release_date.split('-').map(&:to_i)
      Date.
        new(date[0], date[1], date[2])
        .strftime("%Y/%m/%d")
    end

    def poster_path
      "https://image.tmdb.org/t/p/w185//#{@poster_path}"
    end

  end
end
