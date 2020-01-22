module Presenters
  class Movie

    attr_reader :title, :id, :overview

    def initialize data
      @title = data['title']
      @release_date = data['release_date']
      @poster_path = data['poster_path']
      @genre_ids = data['genre_ids']
      @genres = data['genres']
      @id = data['id']
      @overview = data['overview']
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

    def formated_genres genres = {}
      get_genres(genres)
        .map { |genre| genre['name'] }
        .join(', ')
    end

    private

    def get_genres genres
      unless @genre_ids.nil?
      return genres
        .to_a
        .select { |genre| @genre_ids.include?(genre['id']) }
      end
      @genres.to_a
    end

  end
end
