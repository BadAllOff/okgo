class AddCefrlToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :cefrl, :string, default: 'A1'
  end
end
