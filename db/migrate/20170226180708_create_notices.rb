class CreateNotices < ActiveRecord::Migration[5.0]
  def change
    create_table :notices do |t|
      t.references :user, foreign_key: true, null:false
      t.references :activity, foreign_key: true, null:false
      t.datetime :read_at
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
