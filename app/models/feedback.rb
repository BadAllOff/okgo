class Feedback < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable, dependent: :destroy

  validates_presence_of :user, :feedback, :status
  validates_inclusion_of :status, :in => %w( positive negative suggestion )
  validates :feedback, length: { in: 7..2000 }
end