class LanguageSessionsCounter < ApplicationRecord
  belongs_to :user
  belongs_to :language

  validates_uniqueness_of :user_id, scope: [:language_id]
end
