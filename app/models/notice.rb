class Notice < ApplicationRecord
  belongs_to :user, touch: true
  belongs_to :activity, :class_name => "PublicActivity::ORM::ActiveRecord::Activity", touch: true
end
