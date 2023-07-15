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
    it { should validate_numericality_of(:comment_counter).only_integer.is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:like_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe '#update_posts_counter' do
    let!(:author) { User.create(name: 'John Doe') }
    let(:post) { Post.new(title: 'Test Post', author: author) }
  
    it 'updates the author\'s posts_counter' do
      expect {
        post.save # Save the post object
        post.update_posts_counter
      }.to change { post.author.post_counter }.from(0).to(1)
    end
  end
  

  let(:author) { User.create(name: 'John Doe') }
  let!(:post) { Post.create(title: 'Test Post', author: author) }

  describe '#last_five_comments' do
    let!(:comment1) { Comment.new(post_id: post.id, author: author, created_at: 5.days.ago) }
    let!(:comment2) { Comment.new(post_id: post.id, author: author, created_at: 3.days.ago) }
    let!(:comment3) { Comment.new(post_id: post.id, author: author, created_at: 1.day.ago) }
    let!(:comment4) { Comment.new(post_id: post.id, author: author, created_at: 2.days.ago) }
    let!(:comment5) { Comment.new(post_id: post.id, author: author, created_at: 4.days.ago) }

    before do
      comment1.save!
      comment2.save!
      comment3.save!
      comment4.save!
      comment5.save!
    end

    it 'returns the last five comments in descending order of creation' do
      last_five_comments = post.last_five_comments

      expect(last_five_comments.length).to eq(5)
      expect(last_five_comments).to match_array([comment1, comment2, comment3, comment4, comment5])
    end
  end
end

