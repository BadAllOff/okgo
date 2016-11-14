class Event < ApplicationRecord
  belongs_to :user, counter_cache: true
  default_scope { order(starts_at: :asc) }
end
