class Feedback < ApplicationRecord
  belongs_to :user
  validates_presence_of :user, :feedback
  validates :feedback, length: { in: 7..2000 }
end
