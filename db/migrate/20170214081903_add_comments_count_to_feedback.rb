class AddCommentsCountToFeedback < ActiveRecord::Migration[5.0]
  def change
    add_column :feedbacks, :comments_count, :integer, default: 0
  end
end
