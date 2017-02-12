class AddStatusToFeedbacks < ActiveRecord::Migration[5.0]
  def change
    add_column :feedbacks, :status, :string, default: 'positive'
  end
end
