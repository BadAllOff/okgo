class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :commentable, :polymorphic => true

  validates_presence_of :body
  validates :body, length: { maximum: 2000 }
end
