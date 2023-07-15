require_relative '../rails_helper'

RSpec.describe Comment, type: :model do
  subject { described_class.new(text: 'This is user 1 comment in post 1') }

  it 'Post comments counter can be set' do
    subject.post = Post.new(title: 'Post One', text: 'This is the post one')
    subject.post_comments_counter = 3
    expect(subject.post.comments_counter).to be(3)
  end
end
