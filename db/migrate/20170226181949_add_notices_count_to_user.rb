class AddNoticesCountToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :notices_count, :integer, default: 0
  end
end
