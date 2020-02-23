## Movies web app
[![Maintainability](https://api.codeclimate.com/v1/badges/4bbe573ffdf9f9c8aaaa/maintainability)](https://codeclimate.com/github/viniciusalonso/movies-web-app/maintainability)

## Requirements

* Ruby 2.3.7, see how to install [here](https://www.ruby-lang.org/en/documentation/installation/);
* `gem i bunlder`

## Running the application

The following commands below shows how to setup locally:

```console
$ git clone git@github.com:viniciusalonso/movies-web-app.git
$ cd movies-web-app/
$ git checkout development
$ cp .env.example .env

# Set environment variables inside .env

TMDB_API_KEY # Key to access TMDb
TMDB_API_BASE_URL # Base URL of API: https://developers.themoviedb.org/3
ROOT_APP # The absolute path where clone root is located in your machine

$ bundle
```

To run the tests you should run:

```console
$ rspec
```

## Mindset to gets it solution

One important aspect is: it's only an MVP. Thinking in this way I thought of skipping all unnecessary tools at this moment. The main goal of MVP in my point of view is to validate an idea before start to invest more time and energy.

In beginning, I thought to use Ruby on Rails framework, but after thinking better, to use a full-stack framework will only add more complexity than necessary, for example, it will be required to install a database.

I thought also in use Vuejs in front-end and I skipped this idea. Because Vuejs will only add complexity to setup stuffs like Nodejs. Another skipped idea it was to build a SPA app, because this MVP is a content site and this kind of site depends on be finds out, SPA's app doesn't find out for search engineers, generating a problem in SEO.

To keep it simple I decided to use a small framework to handle HTTP requests and separate the concerns in different layers.

## Directories structure

/app                       Application directory

  /helpers                 Helpers to remove logic from views

  /presenters              Format data from model to be presented in views

  /services                Classes focused on access external API

  /public                  Static files like CSS

  /views                   Views

  app.rb                   File that handles http requests and map to services

/spec                      Tests directory

  /integration             Integration tests focused on validate requirements

  /unit                    Unit tests focused on validate messages between classes


## Dependencies

"sinatra": Micro framework to handles HTTP requests

"rspec":  Test tool to write tests

"rack-test": Library used to Mock Http requests on tests

"rack": Application server used to server app in Heroku

'simplecov': Library used to generate code coverage

"dotenv": Map environment variables in .env to application

'faraday': Http client to access external API

'pry' and 'pry-byebug': Used to debug application on dev env.



