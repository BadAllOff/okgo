class AddEventMembershipsCounterToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :event_memberships_count, :integer, default: 0
  end
end
