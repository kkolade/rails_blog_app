require_relative '../rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.create(name: 'Kolade', photo: 'https://unsplash.com/photos/F_-0BxGuVvo', bio: 'A good guy', post_counter: 0) }
  let(:post) { Post.create(title: 'New post', text: 'body of new post', comments_counter: 0, likes_counter: 0, author: user) }
  let(:comment) { Comment.create(text: 'comment on post', author: user, post: post) }
  
  it 'should not be valid without an author' do
    subject.author = nil
    expect(subject).to_not be_valid
  end

  it 'should not be valid without a post' do
    subject.post = nil
    expect(subject).to_not be_valid
  end
end

