module Presenters
  class Movie

    attr_reader :title

    def initialize data
      @title = data['title']
      @release_date = data['release_date']
      @poster_path = data['poster_path']
      @genre_ids = data['genre_ids']
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

    def formated_genres genres
      genres
        .to_a
        .select { |genre| @genre_ids.include?(genre['id']) }
        .map { |genre| genre['name'] }
        .join(', ')
    end

  end
end
