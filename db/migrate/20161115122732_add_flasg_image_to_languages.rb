class AddFlasgImageToLanguages < ActiveRecord::Migration[5.0]
  def up
    add_attachment :languages, :flag_image
  end

  def down
    remove_attachment :languages, :flag_image
  end
end
