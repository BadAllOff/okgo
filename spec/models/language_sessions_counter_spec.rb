require 'rails_helper'

RSpec.describe LanguageSessionsCounter, type: :model do
  it { should belong_to :user }
  it { should belong_to :language }
end
