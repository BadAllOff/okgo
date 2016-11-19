class Event < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :language
  has_many :memberships,  class_name: 'EventMembership', dependent: :destroy

  validates_presence_of :title, :description, :max_members, :starts_at, :ends_at, :language
  validates_date :ends_at, :starts_at, :after => DateTime.current
  validates_datetime :ends_at, after: :starts_at

  default_scope { order(starts_at: :asc) }
end
