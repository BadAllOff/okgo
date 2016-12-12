class Event < ApplicationRecord
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }

  belongs_to :user, counter_cache: true
  belongs_to :language
  has_many :memberships,  class_name: 'EventMembership', dependent: :destroy

  validates_presence_of :title, :description, :max_members, :starts_at, :ends_at, :language
  validates_datetime :ends_at, :starts_at, after: DateTime.current + 24.hours
  validates_datetime :ends_at, after: :starts_at

  default_scope { order(starts_at: :asc) }

  acts_as_likeable

end
