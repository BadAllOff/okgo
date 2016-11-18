class Event < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :language
  has_many :members,  class_name: 'EventMembership', dependent: :destroy
  default_scope { order(starts_at: :asc) }
end
