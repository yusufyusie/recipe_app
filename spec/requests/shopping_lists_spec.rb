require 'rails_helper'

RSpec.describe 'ShoppingLists', type: :request do
  describe 'GET /index' do
    it 'returns http success' do
      get '/shopping_lists/index'
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get '/shopping_lists/index'
      expect(response).to render_template(:index)
    end

    # Add more tests as needed...
  end
end
