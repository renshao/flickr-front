require 'spec_helper'

describe SearchController, :type => :controller do
  describe "#search" do
    it 'renders correct view on positive results' do
      allow(Flickr).to receive(:search) do
        { page: '1', photos: [Photo.new(title: 'photo 1')] }
      end

      get :search, {search: {text: 'apple'}}

      expect(response).to render_template(:has_results)
    end


    it 'renders correct view on zero results' do
      allow(Flickr).to receive(:search) do
        { page: '1', photos: [] }
      end

      get :search, {search: {text: 'orange'}}

      expect(response).to render_template(:no_results)
    end
  end
end