class AddCommentsSounterToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :comments_counter, :integer, default: 0
  end
end
