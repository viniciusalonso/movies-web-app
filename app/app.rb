require 'sinatra'
require_relative './services/movie/upcoming.rb'
require_relative './services/movie/genres.rb'
require_relative './services/movie/details.rb'
require_relative './services/movie/search.rb'
require_relative './helpers/pagination.rb'
require 'dotenv/load'
require 'pry'

base_url = ENV['TMDB_API_BASE_URL']
api_key = ENV['TMDB_API_KEY']
root_app = ENV['ROOT_APP']

get '/' do
  page = params[:page] || 1

  genres_service = Services::Movie::Genres.new(base_url, api_key)
  genres = genres_service.get

  upcoming_service = Services::Movie::Upcoming.new(base_url, api_key, page)
  response = upcoming_service.get
  range = (1..response[:total_pages])

  pagination = Helpers::Pagination.new(range, '/')

  erb :index, locals: { movies: response[:movies] , genres: genres, pagination: pagination  }
end

get '/movie/search' do
  genres_service = Services::Movie::Genres.new(base_url, api_key)
  genres = genres_service.get

  query = params[:query]

  search_service = Services::Movie::Search.new(base_url, api_key, query)
  response = search_service.get

  page = params[:page] || 1

  range = (1..response[:total_pages])
  pagination = Helpers::Pagination.new(range, "/movie/search?query=#{query}&")

  erb :index, locals: { movies: response[:movies], genres: genres, pagination: pagination }
end

get '/movie/:movie_id' do
  movie_id = params[:movie_id]
  details_service = Services::Movie::Details.new(base_url, api_key, movie_id)
  movie = details_service.get

  redirect '/' if movie.nil?

  erb :details, locals: { movie: movie }
end
