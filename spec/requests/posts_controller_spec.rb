require 'rspec'
require 'rails_helper'

RSpec.describe 'PostsController', type: :request do
  let(:user_id) { 1 } # Replace with the actual user ID
  let(:post_id) { 1 } # Replace with the actual post ID

  describe 'GET index' do
    it 'returns a successful response' do
      get user_posts_path(user_id:)
      expect(response).to have_http_status(:success)
    end

    it 'renders the index template' do
      get user_posts_path(user_id:)
      expect(response).to render_template(:index)
    end

    it 'includes correct placeholder text in the response body' do
      get user_posts_path(user_id:)
      expect(response.body).to include('Here is a list of all posts for a specific user')
    end
  end

  describe 'GET show' do
    it 'returns a successful response' do
      get user_post_path(user_id:, id: post_id)
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      get user_post_path(user_id:, id: post_id)
      expect(response).to render_template(:show)
    end

    it 'includes correct placeholder text in the response body' do
      get user_post_path(user_id:, id: post_id)
      expect(response.body).to include('Show specific post for a given user')
    end
  end
end
