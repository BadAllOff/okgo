class CountAllPreviousLanguageSessionsAndSave < ActiveRecord::Migration[5.0]
  def up
    EventMembership.where(attended: true).find_each(batch_size: 50).map{ |e| e.send :increment_language_session_counter }
  end

  def down
    EventMembership.where(attended: true).find_each(batch_size: 50).map{ |e| e.send :decrement_language_session_counter }
  end
end
