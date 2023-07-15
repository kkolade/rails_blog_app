require_relative '../rails_helper'

RSpec.describe Post, type: :model do
  describe 'associations' do
    it { should belong_to(:author).class_name('User').with_foreign_key('author_id') }
    it { should have_many(:comments).dependent(:delete_all) }
    it { should have_many(:likes).dependent(:delete_all) }
  end

  describe 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:title).is_at_most(250) }
    it { should validate_numericality_of(:comments_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:likes_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'callbacks' do
    let(:author) { User.create }
    let(:post) { Post.create(author:) }

    it 'updates the author posts counter after save' do
      expect do
        post.update(title: 'New Title')
        author.reload
      end.to change(author, :posts_counter).by(1)
    end
  end

  describe 'methods' do
    let(:post) { Post.new }
    let(:comments) { create_list(:comment, 10, post:) }

    it 'returns the last five comments' do
      post.comments = comments

      expect(post.last_five_comments).to eq(comments.last(5))
    end
  end
end
