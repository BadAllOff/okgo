class CreateLanguageSessionsCounters < ActiveRecord::Migration[5.0]
  def up
    create_table :language_sessions_counters do |t|
      t.references :user, foreign_key: true
      t.references :language, foreign_key: true
      t.integer :events_count, null: false, default: '0'

      t.timestamps
    end

    add_index :language_sessions_counters, [:user_id, :language_id], unique: true
  end

  def down
    remove_index :language_sessions_counters, [:user_id, :language_id]
    drop_table :language_sessions_counters
  end
end
