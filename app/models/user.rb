class User < ApplicationRecord
  # user should have profile immediately after create.
  # User can only edit profile but not DELETE it.
  # Profile is crucial for app
  after_create :create_profile
  has_many :events, dependent: :destroy
  has_many :event_memberships, dependent: :destroy

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  def profile
    super || build_profile
  end

  def author_of?(object)
    id == object.user_id
  end

  def non_author_of?(object)
    !author_of?(object)
  end

  private

  def create_profile
    Profile.create(user_id: self.id)
  end
end
