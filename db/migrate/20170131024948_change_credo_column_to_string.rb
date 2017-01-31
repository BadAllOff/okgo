class ChangeCredoColumnToString < ActiveRecord::Migration[5.0]
  def up
    change_column :profiles, :credo, :string
  end

  def down
    change_column :profiles, :credo, :text
  end
end
