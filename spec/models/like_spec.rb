require_relative '../rails_helper'

RSpec.describe Like, type: :model do
  let(:user) { User.create(name: 'Kolade', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'A good guy', post_counter: 0) }
  let(:post) { Post.create(title: 'New post', text: 'body of new post', comments_counter: 0, likes_counter: 0, author: user) }

  it 'should not be valid without an author' do
    like = Like.new(post: post)
    expect(like).to_not be_valid
  end

  it 'should not be valid without a post' do
    like = Like.new(user: user)
    expect(like).to_not be_valid
  end
end
