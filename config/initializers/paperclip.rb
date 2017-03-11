Paperclip.interpolates(:photo_placeholder) do |attachment, style|
  ActionController::Base.helpers.asset_path("#{style}_missing.png")
end

Paperclip.interpolates(:cover_image_placeholder) do |attachment, style|
  ActionController::Base.helpers.asset_path("#{style}_cover_image_missing.jpg")
end

Paperclip.interpolates(:event_bg_image) do |attachment, style|
  ActionController::Base.helpers.asset_path("event_bg_image.jpg")
end
