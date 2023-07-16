class RemoveDuplicateAddCommentCounterToPosts < ActiveRecord::Migration[7.0]
  def change
    # Remove the duplicate column migration
    remove_column :posts, :comment_counter
  end
end
