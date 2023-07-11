class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post

  after_save :update_comment_counter

  def update_comment_counter
    author.update_attribute('comment_counter', author.comments.count)
  end
end
