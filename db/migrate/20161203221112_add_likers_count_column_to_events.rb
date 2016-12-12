class AddLikersCountColumnToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :likers_count, :integer, :default => 0
  end
end
