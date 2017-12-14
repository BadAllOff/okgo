class AddReferencesToRatedMemberships < ActiveRecord::Migration[5.0]
  def change
    add_reference :rated_memberships, :user, foreign_key: true, index: true
    add_reference :rated_memberships, :event_membership, foreign_key: true, index: true
    add_column    :rated_memberships, :language_id, :integer, null: false
  end
end
