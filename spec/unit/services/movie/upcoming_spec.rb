require 'sinatra_helper'

describe Services::Movie::Upcoming do

  describe "#get" do

    context 'with valid data' do

      let(:endpoint) { 'https://api/v1/movie/upcoming?api_key=abc&language=en-US&page=1' }

      subject { described_class.new 'https://api/v1', 'abc' }

      let(:result_json) do
        {
          "results": [
            {
              "poster_path": "/y95lQLnuNKdPAzw9F9Ab8kJ80c3.jpg",
              "id": 38700,
              "genre_ids": [
                28,
                80,
                53

              ],
              "title": "Bad Boys for Life",
              "release_date": "2020-01-15"
            },
          ]
        }.to_json
      end

      let(:response) { instance_double('Faraday::Response') }

      before do
        allow(response).to receive(:body).and_return(result_json)
        allow(Faraday).to receive(:get).with(endpoint).and_return(response)
      end

      it 'should build full API url' do
        expect(Faraday).to receive(:get).with(endpoint).and_return(response)

        subject.get
      end

      it 'should returns presenters movie array' do
        expect(subject.get[:movies].length).to eq(1)
        expect(subject.get[:movies].first).to be_instance_of(::Presenters::Movie)
      end
    end

    context 'when missing params' do
      subject { described_class.new 'https://api/v1' }

      it 'should throw an ArgumentError' do
        expect { subject.get }.to raise_error(ArgumentError)
      end
    end
  end

end
