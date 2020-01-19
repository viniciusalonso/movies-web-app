require 'sinatra_helper'
require_relative  "../../app/app.rb"


describe "Upcoming movies app" do
  include Rack::Test::Methods

  def app
    Sinatra::Application
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
  end

end
