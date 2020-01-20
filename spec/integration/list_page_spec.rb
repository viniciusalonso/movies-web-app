require 'sinatra_helper'

describe "Upcoming movies app" do
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
    ]
  end

  before do
    ENV['TMDB_API_KEY'] = 'abc123'
    ENV['TMDB_API_BASE_URL'] = "https://api.themoviedb.org/3/"

    allow_any_instance_of(::Services::Movie::Upcoming).to receive(:get)
      .and_return(movies)
  end

  describe 'GET /' do
    it 'response should be status ok' do
      get '/'

      expect(last_response).to be_ok
    end

    it 'should render html content' do
      get '/'

      expect(last_response.content_type).to eq('text/html;charset=utf-8')
    end

    it 'render movies list' do
      get '/'

      expect(last_response.body).to include("Bad Boys for Life")
      expect(last_response.body).to include("2020/01/15")
      expect(last_response.body).to include("/y95lQLnuNKdPAzw9F9Ab8kJ80c3.jpg")
    end

  end

end
