class AddActivityLevelToRatedMemberships < ActiveRecord::Migration[5.0]
  def change
    add_column :rated_memberships, :activity_level, :integer, null: false
  end
end
