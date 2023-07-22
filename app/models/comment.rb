class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'
  belongs_to :post, counter_cache: true

  def update_comment_counter
    post.update(comment_counter: post.comments.count)
  end

  validates :text, presence: true
  after_save :update_comment_counter
end
