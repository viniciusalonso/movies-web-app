require 'sinatra_helper'

describe "Search movies page" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  let(:movies) do
    [
      ::Presenters::Movie.new({
        "poster_path" => "/y95lQLnuNKdPAzw9F9Ab8kJ80c3.jpg",
        "id" => 38700,
        "genre_ids" => [
          28,
          80,
          53
        ],
        "title" => "Bad Boys for Life",
        "release_date" => "2020-01-15"
      }),

      ::Presenters::Movie.new({
        "poster_path" => "/iiLnuNKdPAzw9F9Ab87718c3.jpg",
        "id" => 9737,
        "genre_ids" => [
          28,
          35,
          80,
          53
        ],
        "title" => "Bad Boys",
      }),
    ]
  end

  let(:genres) do
    [
      {"id" => 28, "name" => "Action"},
      {"id" => 6, "name" => "Horror"},
      {"id" => 8, "name" => "Drama"},
      {"id" => 80, "name" => "Crime"},
      {"id" => 53, "name" => "Thriller"},
    ]
  end

  before do
    ENV['TMDB_API_KEY'] = 'abc123'
    ENV['TMDB_API_BASE_URL'] = "https://api.themoviedb.org/3/"
  end

  describe "GET /movie/search?query=" do
    context 'when entering a parial name' do

      before do
        allow_any_instance_of(::Services::Movie::Search).to receive(:get).and_return(movies)
        allow_any_instance_of(::Services::Movie::Genres).to receive(:get).and_return(genres)
      end

      it 'should render movies' do
        get '/movie/search?query=Bad+B'

        expect(last_response.body).to include("Bad Boys for Life")
        expect(last_response.body).to include("2020/01/15")
        expect(last_response.body).to include("/y95lQLnuNKdPAzw9F9Ab8kJ80c3.jpg")
        expect(last_response.body).to include("38700")

        expect(last_response.body).to include("Bad Boys")
        expect(last_response.body).to include("-")
        expect(last_response.body).to include("/iiLnuNKdPAzw9F9Ab87718c3.jpg")
        expect(last_response.body).to include("9737")
      end

      it 'should have status ok' do
        get '/movie/search?query=Bad+B'

        expect(last_response).to be_ok
      end

      it 'should render html content' do
        get '/movie/search?query=Bad+B'

        expect(last_response.content_type).to eq('text/html;charset=utf-8')
      end
    end
    context 'when entering a full name' do

      before do
        allow_any_instance_of(::Services::Movie::Search).to receive(:get).and_return([movies.first])
        allow_any_instance_of(::Services::Movie::Genres).to receive(:get).and_return(genres)
      end

      it 'should render single movie' do
        get '/movie/search?query=Bad+Boys+for+Life'

        expect(last_response.body).to include("Bad Boys for Life")
        expect(last_response.body).to include("2020/01/15")
        expect(last_response.body).to include("/y95lQLnuNKdPAzw9F9Ab8kJ80c3.jpg")
        expect(last_response.body).to include("38700")

        expect(last_response.body).to_not include("/iiLnuNKdPAzw9F9Ab87718c3.jpg")
        expect(last_response.body).to_not include("9737")
      end
    end

  end


end
