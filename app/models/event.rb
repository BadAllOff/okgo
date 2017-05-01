class Event < ApplicationRecord
  include PublicActivity::Common

  belongs_to :user, counter_cache: true, touch: true
  belongs_to :language, counter_cache: true, touch: true
  has_many :memberships,  class_name: 'EventMembership', dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :activities, as: :trackable, class_name: 'PublicActivity::Activity', dependent: :destroy

  has_attached_file :event_bg_image,
                    styles: { original: '550x150#' },
                    default_url: ':event_bg_image'

  validates_attachment :event_bg_image, content_type: { content_type: ['image/jpeg', 'image/png'] }
  validates_with AttachmentSizeValidator, attributes: :event_bg_image, less_than: 1.megabytes

  validates_presence_of :max_members, :language
  validates_datetime :ends_at, :starts_at, after: DateTime.current + 24.hours
  validates_datetime :ends_at, after: :starts_at
  validates_datetime :ends_at, before: DateTime.current + 1.month
  validates_numericality_of :latitude, :longitude
  validates :title, length: { in: 4..140 }
  validates :description, length: { in: 10..3000 }
  validates :address, length: { in: 10..255 }

  acts_as_likeable
  acts_as_followable

  def joinable?(membership)
    return false if user == membership.user
    return false if starts_at < Time.zone.now
    return true
  end

end
