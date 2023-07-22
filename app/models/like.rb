class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  def update_like_counter
    # post.update(like_counter: post.likes.count)
    post.update(like_count: post.likes.count)
  end

  after_save :update_like_counter
end
