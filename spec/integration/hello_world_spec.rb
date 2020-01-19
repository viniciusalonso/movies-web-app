ENV['APP_ENV'] = 'test'

require_relative  "../../app/app.rb"

require 'rspec'
require 'rack/test'

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
