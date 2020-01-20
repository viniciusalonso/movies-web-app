require 'sinatra_helper'

describe Presenters::Movie do

  let(:params) do
    {
      "poster_path" =>"/y95lQLnuNKdPAzw9F9Ab8kJ80c3.jpg",
      "title" =>"Bad Boys for Life",
      "release_date" =>"2020-01-15"
    }
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

end
