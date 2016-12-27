class Event < ApplicationRecord
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  belongs_to :user, counter_cache: true
  belongs_to :language
  has_many :memberships,  class_name: 'EventMembership', dependent: :destroy

  validates_presence_of :title, :description, :max_members, :starts_at, :ends_at, :language, :latitude, :longitude
  validates_datetime :ends_at, :starts_at, after: DateTime.current + 24.hours
  validates_datetime :ends_at, after: :starts_at
  validates_numericality_of :latitude, :longitude

  acts_as_likeable

  def joinable?(membership)
    return false if user == membership.user
    return false if starts_at < Time.zone.now
    return true
  end

end
