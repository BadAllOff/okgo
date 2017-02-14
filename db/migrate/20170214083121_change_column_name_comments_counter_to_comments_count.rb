class ChangeColumnNameCommentsCounterToCommentsCount < ActiveRecord::Migration[5.0]
  def change
    rename_column :events, :comments_counter, :comments_count
  end
end
