require 'sinatra_helper'

describe Helpers::Pagination do
  describe "#paginate" do
    it 'should mount a href list' do
      range = (1..3)
      helper = described_class.new(range, '/my-link')

      hrefs = helper.paginate

      expect(hrefs[0]).to eq('/my-link?page=1')
      expect(hrefs[1]).to eq('/my-link?page=2')
      expect(hrefs[2]).to eq('/my-link?page=3')
    end
  end
end
