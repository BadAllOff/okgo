class CreateEventMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :event_memberships do |t|
      t.references :event, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :event_memberships, [:event_id, :user_id]
  end
end
