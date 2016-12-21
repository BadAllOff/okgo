class EventMembership < ApplicationRecord
  # before_validation :check_authorship
  belongs_to :event
  belongs_to :user

  validates_uniqueness_of :user_id, scope: [:event_id]

  private

  # def check_authorship
  #   :abort if event.user.id == user.id
  #   true
  # end

end
