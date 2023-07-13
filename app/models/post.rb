class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  has_many :comments, dependent: :delete_all
  has_many :likes, dependent: :delete_all

  def update_post_counter
    author.update_attribute('post_counter', author.posts.count)
  end

  def last_five_comments
    comments.order(created_at: :desc).limit(5)
  end
end
