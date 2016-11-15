class AddMaximumMembersColumnToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :max_members, :integer, default: 10
  end
end
