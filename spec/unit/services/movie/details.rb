require 'sinatra_helper'

describe Services::Movie::Details do

  describe "#get" do

    context 'with valid movie id' do

      let(:endpoint) { 'https://api/v1/movie/38700?api_key=abc&language=en-US' }

      subject { described_class.new 'https://api/v1', 'abc', 38700 }

      let(:result_json) do
        {
          "results": [
            {
              "poster_path": "/y95lQLnuNKdPAzw9F9Ab8kJ80c3.jpg",
              "id": 38700,
              "genres" => [
                {"id" => 28, "name" => "Action"},
                {"id" => 80, "name" => "Crime"},
                {"id" => 53, "name" => "Thriller"},
              ],              "title": "Bad Boys for Life",
              "release_date": "2020-01-15",
              "overview" => "Marcus and Mike are forced to confront new threats ..."
            },
          ]
        }.to_json
      end

      let(:response) { instance_double('Faraday::Response') }

      before do
        allow(response).to receive(:body).and_return(result_json)
        allow(response).to receive(:status).and_return(200)
        allow(Faraday).to receive(:get).with(endpoint).and_return(response)
      end

      it 'should build full API url' do
        expect(Faraday).to receive(:get).with(endpoint).and_return(response)

        subject.get
      end

      it 'should returns movie presenter' do
        expect(subject.get).to be_instance_of(::Presenters::Movie)
      end
    end

    context 'with invalid movie id' do
      subject { described_class.new 'https://api/v1', 'abc', 1 }

      let(:endpoint) { 'https://api/v1/movie/1?api_key=abc&language=en-US' }

      let(:result_json) do
        {
          "status_code": 34,
          "status_message": "The resource you request could not be found"

        }.to_json
      end

      let(:response) { instance_double('Faraday::Response') }

      before do
        allow(response).to receive(:body).and_return(result_json)
        allow(response).to receive(:status).and_return(404)
        allow(Faraday).to receive(:get).with(endpoint).and_return(response)
      end

      it 'returns movie nil' do
        expect(Faraday).to receive(:get).with(endpoint).and_return(response)
        expect(subject.get).to be_nil
      end
    end
  end

end
