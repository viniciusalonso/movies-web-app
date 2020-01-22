require 'sinatra_helper'

describe "Show movie details" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  let(:movie) do
      ::Presenters::Movie.new({
        "poster_path" => "/y95lQLnuNKdPAzw9F9Ab8kJ80c3.jpg",
        "id" => 38700,
        "genres" => [
          {"id" => 28, "name" => "Action"},
          {"id" => 80, "name" => "Crime"},
          {"id" => 53, "name" => "Thriller"},
        ],
        "title" => "Bad Boys for Life",
        "release_date" => "2020-01-15"
      })
  end

  before do
    ENV['TMDB_API_KEY'] = 'abc123'
    ENV['TMDB_API_BASE_URL'] = "https://api.themoviedb.org/3/"

    allow_any_instance_of(::Services::Movie::Details).to receive(:get)
      .and_return(movie)
  end

  describe 'GET /movie/38700' do
    context 'with a valid movie id' do
    it 'response should be status ok' do
      get '/movie/38700'

      expect(last_response).to be_ok
    end

    it 'should render html content' do
      get '/movie/38700'

      expect(last_response.content_type).to eq('text/html;charset=utf-8')
    end

    it 'render movies list' do
      get '/movie/38700'

      expect(last_response.body).to include("Bad Boys for Life")
      expect(last_response.body).to include("2020/01/15")
      expect(last_response.body).to include("/y95lQLnuNKdPAzw9F9Ab8kJ80c3.jpg")
    end

    it 'show genres list to movie' do
      get '/movie/38700'

      expect(last_response.body).to include("Action, Crime, Thriller")
    end

    end
    # context 'with a invalid movie id' do
    #   let(:not_found)  { "The resource you request could not be found" }

    #   before do
    #     allow_any_instance_of(::Services::Movie::Details).to receive(:get)
    #       .and_return(not_found)
    #   end

    #   subject { get '/movie/111111111111' }

    #   it 'redirect to listing' do
    #     expect(subject).to redirect_to('/')
    #   end
    # end

  end
end
