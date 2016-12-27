class AddAttendedColumnToEventMembership < ActiveRecord::Migration[5.0]
  def change
    add_column :event_memberships, :attended, :boolean, deafult:false
    add_column :event_memberships, :marked, :boolean, deafult:false
  end
end
