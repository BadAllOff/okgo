class ChangeUniqueIdentifierColumnDefaultToProfiles < ActiveRecord::Migration[5.0]
  def change
    change_column :profiles, :unique_identifier, :string, null: false
  end
end
