class EventMembership < ApplicationRecord
  # before_validation :check_authorship
  belongs_to :event, counter_cache: true, touch: true
  belongs_to :user, counter_cache: true, touch: true
  has_one :profile, through: :user
  has_many :rated_memberships, dependent: :destroy

  validates_uniqueness_of :user_id, scope: [:event_id]
  validates_numericality_of :user_id

  after_save :increment_language_session_counter
  before_destroy :decrement_language_session_counter
  # before_destroy :decrement_members_counter

  def joinable?
    return false if self.event.user != self.user
    return false if self.event.starts_at > Time.zone.now
    true
  end

  private

  def increment_language_session_counter
    lang_session = LanguageSessionsCounter.where(user: self.user_id, language: self.event.language_id).first_or_create
    lang_session.increment!(:events_count)
  end

  def decrement_language_session_counter
    lang_session = LanguageSessionsCounter.where(user: self.user_id, language: self.event.language_id).first
    lang_session.decrement!(:events_count) unless lang_session.blank?
  end

  # def increment_members_counter
  #   Event.increment_counter(:members_count, self.event)
  # end
  #
  # def decrement_members_counter
  #   Event.decrement_counter(:members_count, self.event)
  # end

  # def check_authorship
  #   :abort if event.user.id == user.id
  #   true
  # end

end
