class CreateEventMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :event_memberships do |t|
      t.integer :event_id
      t.integer :user_id

      t.timestamps
    end

    add_index :event_memberships, [:event_id, :user_id]
  end
end
