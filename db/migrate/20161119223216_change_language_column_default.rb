class ChangeLanguageColumnDefault < ActiveRecord::Migration[5.0]
  def change
    change_column_default :events, :language_id, 1
  end
end
