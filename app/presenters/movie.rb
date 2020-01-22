module Presenters
  class Movie

    attr_reader :title, :id, :overview

    def initialize data
      @title = data['title']
      @release_date = data['release_date']
      @poster_path = data['poster_path']
      @backdrop_path = data['backdrop_path']
      @genre_ids = data['genre_ids']
      @genres = data['genres']
      @id = data['id']
      @overview = data['overview']
    end

    def release_date
      begin
        date = @release_date.split('-').map(&:to_i)
        Date.
          new(date[0], date[1], date[2])
          .strftime("%Y/%m/%d")
      rescue
        '-'
      end
    end

    def image_path
      return "https://image.tmdb.org/t/p/w185//#{@poster_path}" unless @poster_path.nil?
      return "https://image.tmdb.org/t/p/w185//#{@backdrop_path}" unless @backdrop_path.nil?
      "https://carolinadojo.com/wp-content/uploads/2017/04/default-image.jpg"
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
