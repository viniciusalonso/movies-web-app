require 'sinatra_helper'

describe Presenters::Movie do

  let(:params) do
    {
      "poster_path" =>"/y95lQLnuNKdPAzw9F9Ab8kJ80c3.jpg",
      "title" =>"Bad Boys for Life",
      "release_date" =>"2020-01-15",
      "genre_ids" => [4, 8]
    }
  end

  let(:genres) do
    [
      {"id" => 4, "name" => "Action"},
      {"id" => 6, "name" => "Horror"},
      {"id" => 8, "name" => "Drama"},
    ]
  end

  subject {  described_class.new params }

  describe "#title" do
    it 'should be equals to params' do
      expect(subject.title).to eq("Bad Boys for Life")
    end
  end

  describe "#release_date" do
    it 'should format date YYYY/MM/DD' do
      expect(subject.release_date).to eq("2020/01/15")
    end
  end

  describe "#poster_path" do
    it 'should returns full url from image' do
      url = "https://image.tmdb.org/t/p/w185///y95lQLnuNKdPAzw9F9Ab8kJ80c3.jpg"
      expect(subject.poster_path).to eq(url)
    end
  end

  describe "#formated_genres" do
    it 'returns genres joined string' do
      string = "Action, Drama"
      expect(subject.formated_genres(genres)).to eq(string)
    end
  end

end
