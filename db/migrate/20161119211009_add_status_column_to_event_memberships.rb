class AddStatusColumnToEventMemberships < ActiveRecord::Migration[5.0]
  def change
    add_column :event_memberships, :status, :boolean, default: false
  end
end
