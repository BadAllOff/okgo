class CreateRatedMemberships < ActiveRecord::Migration[5.0]
  def change
    create_table :rated_memberships do |t|
      t.integer :language_level

      t.timestamps
    end
  end
end
