require 'sinatra'
require_relative './services/movie/upcoming.rb'
require_relative './services/movie/genres.rb'
require 'dotenv/load'

base_url = ENV['TMDB_API_BASE_URL']
api_key = ENV['TMDB_API_KEY']
root_app = ENV['ROOT_APP']

genres_service = Services::Movie::Genres.new(base_url, api_key)
genres = genres_service.get

get '/' do
  upcoming_service = Services::Movie::Upcoming.new(base_url, api_key)
  erb :index, locals: { movies: upcoming_service.get, genres: genres  }
end
