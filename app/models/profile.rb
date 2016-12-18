class Profile < ApplicationRecord
  belongs_to :user
  # :placeholder-s initialized in paperclip.rb initializer
  has_attached_file :photo,
                    styles: { micro: '50x50#', small: '128x128#', medium: '160x160#', original: '250x250#' },
                    default_url: ':photo_placeholder'
  has_attached_file :cover_image,
                    styles: { original: '1380x120#', thumb: '305x100#' },
                    default_url: ':cover_image_placeholder'

  validates_attachment :photo, content_type: { content_type: ['image/jpeg', 'image/png'] }
  validates_attachment :cover_image, content_type: { content_type: ['image/jpeg', 'image/png'] }
  validates_with AttachmentSizeValidator, attributes: :photo, less_than: 1.megabytes
  validates_with AttachmentSizeValidator, attributes: :cover_image, less_than: 1.megabytes
  validates_uniqueness_of :user_id
  validates_inclusion_of :gender, in: %w( Female Male Other )
  validates_presence_of :firstname, :lastname, :gender
  validates :firstname, length: { in: 1..20 }
  validates :lastname, length: { in: 1..20 }
end
