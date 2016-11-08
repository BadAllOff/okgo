class Profile < ApplicationRecord
  belongs_to :user, optional: true
  # :placeholder initialized in paperclip.rb initializer
  has_attached_file :photo, styles: { micro: '50x50#', small: '128x128#', medium: '160x160#', original: '250x250#' }, default_url: ":placeholder"
  validates_attachment_content_type :photo, content_type: /\Aimage\/.*\z/
  validates_uniqueness_of :user_id
  validates_inclusion_of :gender, :in => %w( Female Male Other )
  validates_presence_of :firstname, :lastname, :gender
end
