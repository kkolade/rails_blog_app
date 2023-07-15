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

  describe '#last_three_posts' do
    let(:user) { User.create(name: 'John Doe') }

    context 'with posts' do
      let!(:oldest_post) { Post.new(author: user, title: 'Oldest Post', created_at: 5.days.ago).tap(&:save!) }
      let!(:newest_post) { Post.new(author: user, title: 'Newest Post', created_at: 1.day.ago).tap(&:save!) }
      let!(:middle_post) { Post.new(author: user, title: 'Middle Post', created_at: 3.days.ago).tap(&:save!) }

      it 'returns the last three posts in descending order of creation' do
        last_three_posts = user.last_three_posts

        expect(last_three_posts).to match_array([newest_post, middle_post, oldest_post])
      end
    end

    context 'without posts' do
      it 'returns an empty array' do
        last_three_posts = user.last_three_posts

        expect(last_three_posts).to eq([])
      end
    end


  end
end
