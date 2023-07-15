class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'author_id'
  belongs_to :post

  def update_post_likes_counter
    author.update(likes_counter: author.likes.count)
  end
end
