require 'sinatra_helper'

describe Presenters::Movie do

  let(:params) do
    {
      "poster_path" =>"/y95lQLnuNKdPAzw9F9Ab8kJ80c3.jpg",
      "title" =>"Bad Boys for Life",
      "release_date" =>"2020-01-15",
      "genre_ids" => [4, 8],
      "id" => 38700
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
    context 'when date is 2020-01-15' do
      it 'should format date YYYY/MM/DD' do
        expect(subject.release_date).to eq("2020/01/15")
      end
    end

    context 'when date is empty' do
      let(:params_empty_date) do
        {
          "poster_path" =>"/y95lQLnuNKdPAzw9F9Ab8kJ80c3.jpg",
          "title" =>"Bad Boys for Life",
          "release_date" =>"",
          "genre_ids" => [4, 8],
          "id" => 38700
        }
      end

      it 'returns simple string' do
        presenter = described_class.new params_empty_date
        expect(presenter.release_date).to eq('-')
      end
    end
  end

  describe "#image_path" do
    let(:params_with_poster_path) do
      {
        "poster_path" =>"/y95lQLnuNKdPAzw9F9Ab8kJ80c3.jpg",
        "title" =>"Bad Boys for Life",
        "release_date" =>"2020-01-15",
        "genre_ids" => [4, 8],
        "id" => 38700
      }
    end

    let(:params_with_backdrop_path) do
      {
        "backdrop_path" =>"/backdrop_path.jpg",
        "title" =>"Bad Boys for Life",
        "release_date" =>"2020-01-15",
        "genre_ids" => [4, 8],
        "id" => 38700
      }
    end

    let(:params_without_image) do
      {
        "title" =>"Bad Boys for Life",
        "release_date" =>"2020-01-15",
        "genre_ids" => [4, 8],
        "id" => 38700
      }
    end


    context 'should returns full url from image' do

      it 'when poster_path is params' do
        url = "https://image.tmdb.org/t/p/w185///y95lQLnuNKdPAzw9F9Ab8kJ80c3.jpg"
        presenter = described_class.new params_with_poster_path
        expect(subject.image_path).to eq(url)
      end

      it 'when backdrop_path is params' do
        url = "https://image.tmdb.org/t/p/w185///backdrop_path.jpg"
        presenter = described_class.new params_with_backdrop_path
        expect(presenter.image_path).to eq(url)
      end
    end

    context 'when has not image' do
      it 'should load default image' do
        default_image_url = "https://carolinadojo.com/wp-content/uploads/2017/04/default-image.jpg"
        presenter = described_class.new params_without_image
        expect(presenter.image_path).to eq(default_image_url)
      end
    end

  end

  describe "#formated_genres" do
    it 'returns genres joined string' do
      string = "Action, Drama"
      expect(subject.formated_genres(genres)).to eq(string)
    end
  end

  describe "#id" do
    it 'returns movie id' do
      expect(subject.id).to eq(38700)
    end
  end

end
