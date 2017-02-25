class Feedback < ApplicationRecord
  include PublicActivity::Common

  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  acts_as_likeable
  acts_as_followable

  validates_presence_of :user, :feedback, :status
  validates_inclusion_of :status, :in => %w( positive negative suggestion )
  validates :feedback, length: { in: 7..2000 }
end
