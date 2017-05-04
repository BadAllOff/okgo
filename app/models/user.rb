class User < ApplicationRecord
  include Omniauthable

  enum role: { guest: 0, user: 1, admin: 2 }
  # User should have profile immediately after create.
  # User can only edit profile but not DELETE it.
  # Profile is crucial for app
  after_create :create_profile
  has_many :events, dependent: :destroy
  has_many :event_memberships, dependent: :destroy
  has_many :rated_memberships, dependent: :destroy
  has_many :feedbacks, dependent: :destroy
  has_many :notices, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable, omniauth_providers: [:facebook]
  has_one :profile, dependent: :destroy
  has_many :comments, dependent: :destroy
  accepts_nested_attributes_for :profile

  acts_as_liker
  acts_as_follower

  def profile
    super || build_profile
  end

  def author_of?(object)
    id == object.user_id
  end

  def non_author_of?(object)
    !author_of?(object)
  end

  def member_of?(event)
    event_memberships.where(event_id: event).exists?
  end

  def rated_membership?(membership)
    RatedMembership.where(user_id: id, event_membership_id: membership.id).first
  end

  def not_rated_membership?(membership)
    !rated_membership?(membership)
  end

  def can_rate_membership?(membership)
    if author_of?(membership.event) && membership.attended?
      true
    else
      false
    end
  end

  def active_for_authentication?
    super && !self.blocked
  end

  private

  def create_profile
    Profile.create(user_id: self.id)
  end
end
