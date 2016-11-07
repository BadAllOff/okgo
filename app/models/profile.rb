class Profile < ApplicationRecord
  belongs_to :user
  validates_uniqueness_of :user_id
  validates_inclusion_of :gender, :in => %w( Female Male other )
end
