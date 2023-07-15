require_relative '../rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:posts).with_foreign_key('author_id') }
    it { should have_many(:comments).with_foreign_key('author_id') }
    it { should have_many(:likes).with_foreign_key('author_id') }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_numericality_of(:post_counter).only_integer.is_greater_than_or_equal_to(0) }
  end

  describe 'methods' do
    let(:user) { User.new }
    let(:posts) { create_list(:post, 5, author: user) }

    it 'returns the last three posts' do
      user.posts = posts

      expect(user.last_three_posts).to eq(posts.last(3))
    end
  end
end