class Post < ApplicationRecord
  attribute :comments_counter
  attribute :like_counter

  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, dependent: :delete_all, counter_cache: :comment_counter
  has_many :likes, dependent: :destroy, counter_cache: :like_counter

  validates :title, presence: true, length: { maximum: 250 }
  validates :comment_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :like_counter, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def update_posts_counter
    author.update(post_counter: author.posts.count)
  end

  def last_five_comments
    comments.order(created_at: :desc).limit(5)
  end
end
