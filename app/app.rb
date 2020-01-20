require 'sinatra'
require_relative './services/movie/upcoming.rb'
require 'dotenv/load'

base_url = ENV['TMDB_API_BASE_URL']
api_key = ENV['TMDB_API_KEY']
root_app = ENV['ROOT_APP']

get '/' do
  service = Services::Movie::Upcoming.new(base_url, api_key)
  erb :index, locals: { movies: service.get  }
end
