class Notice < ApplicationRecord
  belongs_to :user
  belongs_to :activity, :class_name => "PublicActivity::ORM::ActiveRecord::Activity"
end
