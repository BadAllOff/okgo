class RatedMembership < ApplicationRecord
  belongs_to :user
  belongs_to :event_membership
  belongs_to :language

  validates_uniqueness_of :user_id, scope: [:rated_member_id, :event_membership_id]
  validates_presence_of :user, :event_membership, :language, :rated_member_id, :language_level, :activity_level
  validates_numericality_of :language_level, :activity_level
  # validates_inclusion_of :language_level, :activity_level, in: 1..100
end
