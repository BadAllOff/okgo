class AddMembersCountToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :event_memberships_count, :integer, default: 0
  end
end
