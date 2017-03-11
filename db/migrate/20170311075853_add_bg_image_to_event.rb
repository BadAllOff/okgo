class AddBgImageToEvent < ActiveRecord::Migration[5.0]
  def up
    add_attachment :events, :event_bg_image
  end

  def down
    remove_attachment :events, :event_bg_image
  end
end
