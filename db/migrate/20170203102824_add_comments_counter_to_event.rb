class AddCommentsCounterToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :comments_counter, :integer, default: 0
  end
end
