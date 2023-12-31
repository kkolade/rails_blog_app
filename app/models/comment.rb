class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def update_comments_counter
    post.update(comments_counter: post.comments.count)
  end

  validates :text, presence: true
  after_save :update_comments_counter
end
