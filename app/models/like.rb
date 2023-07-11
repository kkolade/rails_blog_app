class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  after_save :update_post_likes_counter

  def update_post_likes_counter
    author.update_attribute('likes_counter', author.likes.count)
  end
end
