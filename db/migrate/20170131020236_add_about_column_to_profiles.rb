class AddAboutColumnToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :about, :text
  end
end
