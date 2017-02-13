class AddUniqueIdentifierToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :unique_identifier, :string
    add_index :profiles, :unique_identifier, :unique => true

    Profile.find_each do |profile|
      profile.send(:create_unique_identifier) if profile.unique_identifier.blank?
      profile.save!
    end
  end
end
