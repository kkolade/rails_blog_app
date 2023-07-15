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
    let(:author) { create(:user) }
    let!(:post1) { create(:post, author: author) }
    let!(:post2) { create(:post, author: author) }

    it 'updates the author\'s posts_counter' do
      expect {
        post2.update_posts_counter
      }.to change { author.reload.posts_counter }.from(1).to(2)
    end
  end

  describe '#last_five_comments' do
    let(:post) { create(:post) }
    let!(:comment1) { create(:comment, post: post, created_at: 5.days.ago) }
    let!(:comment2) { create(:comment, post: post, created_at: 3.days.ago) }
    let!(:comment3) { create(:comment, post: post, created_at: 1.day.ago) }
    let!(:comment4) { create(:comment, post: post, created_at: 2.days.ago) }
    let!(:comment5) { create(:comment, post: post, created_at: 4.days.ago) }
    let!(:comment6) { create(:comment, post: create(:post)) } # Another post's comment

    it 'returns the last five comments in descending order of creation' do
      last_five_comments = post.last_five_comments

      expect(last_five_comments.length).to eq(5)
      expect(last_five_comments).to eq([comment3, comment2, comment4, comment5, comment1])
    end
  end
end
