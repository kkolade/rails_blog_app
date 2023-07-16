class UpdateLikesForeignKey < ActiveRecord::Migration[7.0]
  def change
    change_column :likes, :author_id, :bigint, null: false
  end
end
