class Notice < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :activity
end
