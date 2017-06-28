class Language < ApplicationRecord
  has_many :events, dependent: :destroy
  has_many :rated_memberships, dependent: :destroy
  has_many :language_sessions_counters, dependent: :destroy
  validates_presence_of :description
  has_attached_file :flag_image, styles: { micro: '30x20#', small: '60x40#', medium: '120x80#', original: '240x160#' }
  validates_attachment :flag_image, content_type: { content_type: ['image/jpeg', 'image/png'] }
  validates_with AttachmentSizeValidator, attributes: :flag_image, less_than: 1.megabytes
end
