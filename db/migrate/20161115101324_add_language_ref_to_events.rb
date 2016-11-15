class AddLanguageRefToEvents < ActiveRecord::Migration[5.0]
  def change
    add_reference :events, :language, foreign_key: true
  end
end
