class AddRatedIdRatedMemberships < ActiveRecord::Migration[5.0]
  def change
    add_column :rated_memberships, :rated_member_id, :integer, null: false
  end
end
