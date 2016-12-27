class EventMembership < ApplicationRecord
  # before_validation :check_authorship
  belongs_to :event
  belongs_to :user

  validates_uniqueness_of :user_id, scope: [:event_id]
  validates_numericality_of :member_id

  def joinable?
    return false if self.event.user != self.user
    return false if self.event.starts_at > Time.zone.now
    true
  end

  private

  # def check_authorship
  #   :abort if event.user.id == user.id
  #   true
  # end

end
