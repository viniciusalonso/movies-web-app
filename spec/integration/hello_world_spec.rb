require 'sinatra_helper'
require_relative  "../../app/app.rb"


describe "Upcomming movies app" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it 'says Hello World' do
    get '/'
    expect(last_response.body).to eq('Hello World!')
  end
end
