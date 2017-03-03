class Comment < ApplicationRecord
  belongs_to :user, touch: true
  belongs_to :commentable, :polymorphic => true, touch: true

  validates_presence_of :body
  validates :body, length: { maximum: 2000 }
end
