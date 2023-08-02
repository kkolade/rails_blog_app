require_relative '../rails_helper'

RSpec.describe 'Likes', type: :request do
  describe 'POST /posts/:post_id/likes' do
    it 'creates a new like and returns http success' do
      # Create a post first
      post = Post.create(title: 'Test Post', content: 'Test content')

      # Send a POST request to create a like for the post
      post "/posts/#{post.id}/likes"

      # Expect a successful response
      expect(response).to have_http_status(:success)

      # You can also expect changes in the database
      expect(Like.count).to eq(1)
    end
  end
end
