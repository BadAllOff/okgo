class Event < ApplicationRecord
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  belongs_to :user, counter_cache: true
  belongs_to :language, counter_cache: true
  has_many :memberships,  class_name: 'EventMembership', dependent: :destroy
  has_many :comments, as: :commentable, dependent: :destroy

  validates_presence_of :title, :description, :max_members, :starts_at, :ends_at, :language, :latitude, :longitude, :address
  validates_datetime :ends_at, :starts_at, after: DateTime.current + 24.hours
  validates_datetime :ends_at, after: :starts_at
  validates_datetime :ends_at, before: DateTime.current + 1.month
  validates_numericality_of :latitude, :longitude
  validates :title, length: { in: 4..140 }
  validates :description, length: { in: 10..3000 }
  validates :address, length: { in: 10..255 }

  acts_as_likeable

  def joinable?(membership)
    return false if user == membership.user
    return false if starts_at < Time.zone.now
    return true
  end

end
