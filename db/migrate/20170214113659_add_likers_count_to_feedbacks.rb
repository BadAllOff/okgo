class AddLikersCountToFeedbacks < ActiveRecord::Migration[5.0]
  def change
    add_column :feedbacks, :likers_count, :integer, default: 0
  end
end
