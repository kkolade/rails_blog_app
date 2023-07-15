require_relative '../rails_helper'

RSpec.describe Like, type: :model do
  describe 'associations' do
    it { should belong_to(:author).class_name('User').with_foreign_key('author_id') }
    it { should belong_to(:post) }
  end

  describe 'methods' do
    let(:like) { Like.new }
    let(:post) { Post.create }

    it 'updates the post likes counter' do
      like.post = post
      like.post_likes_counter = 10

      expect(post.reload.likes_counter).to eq(10)
    end
  end
end
