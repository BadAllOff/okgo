class AddFollowersCountToEvent < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :followers_count, :integer, :default => 0
  end
end
