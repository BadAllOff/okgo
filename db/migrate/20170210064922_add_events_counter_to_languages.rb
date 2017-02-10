class AddEventsCounterToLanguages < ActiveRecord::Migration[5.0]
  def change
    add_column :languages, :events_count, :integer, default: 0

    reversible do |dir|
      dir.up { data }
    end
  end

  def data
    execute <<-SQL.squish
        UPDATE languages
           SET events_count = (SELECT count(1)
                                   FROM events
                                  WHERE events.language_id = languages.id)
    SQL
  end
end
