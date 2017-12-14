class ChangeColumnNameCommentsCounterToCommentsCountInUsers < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :comments_counter, :comments_count
  end
end
