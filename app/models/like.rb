class Like < ApplicationRecord
  belongs_to :user, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post

  after_create :update_likes_counter

  def update_likes_counter
    post.update(likes_counter: post.likes.count)
  end
end
