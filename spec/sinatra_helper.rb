require 'simplecov'
SimpleCov.start
require 'pry'

root_app = ENV['ROOT_APP']
Dir[
  "#{root_app}app/*.rb",
  "#{root_app}app/*/*.rb",
  "#{root_app}app/*/*/*.rb"].map { |file| file.gsub('.rb', '') }
  .each { |file| require_relative "../#{file}"  }

require 'spec_helper'

ENV['APP_ENV'] = 'test'
require 'rspec'
require 'rack/test'
