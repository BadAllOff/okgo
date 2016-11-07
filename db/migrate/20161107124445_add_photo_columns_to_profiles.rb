class AddPhotoColumnsToProfiles < ActiveRecord::Migration[5.0]
  def up
    add_attachment :profiles, :photo
  end

  def down
    remove_attachment :profiles, :photo
  end
end
