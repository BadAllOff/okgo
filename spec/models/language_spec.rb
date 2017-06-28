require 'rails_helper'

RSpec.describe Language, type: :model do
  describe 'Associations' do
    it { should have_many(:events).dependent(:destroy)  }
    it { should have_many(:rated_memberships).dependent(:destroy)  }
    it { should have_many(:language_sessions_counters).dependent(:destroy) }
  end

  describe 'Validations' do
    it { should validate_presence_of :description }
  end
end
