class AddCoverImagesToProfiles < ActiveRecord::Migration[5.0]
  def up
    add_attachment :profiles, :cover_image
  end

  def down
    remove_attachment :profiles, :cover_image
  end
end
