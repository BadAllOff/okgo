class CreateComments < ActiveRecord::Migration[5.0]
  def self.up
    create_table :comments do |t|
      t.references :commentable, :polymorphic => true
      t.references :user, null: false
      t.text :body

      t.timestamps
    end

    add_index :comments, :commentable_type
    add_index :comments, :commentable_id
  end

  def self.down
    remove_index :comments, :commentable_type
    remove_index :comments, :commentable_id
    drop_table :comments
  end
end
