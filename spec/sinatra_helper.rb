require 'simplecov'
SimpleCov.start

require 'spec_helper'

ENV['APP_ENV'] = 'test'
require 'rspec'
require 'rack/test'
