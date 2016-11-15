class Event < ApplicationRecord
  belongs_to :user, counter_cache: true
  belongs_to :language
  default_scope { order(starts_at: :asc) }
end
