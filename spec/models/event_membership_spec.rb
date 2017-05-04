require 'rails_helper'

RSpec.describe EventMembership, type: :model do
  describe 'Associations' do
    it { should belong_to :user }
    it { should belong_to :event }
    it { should have_many(:rated_memberships).dependent(:destroy) }
    it { should have_one(:profile)}
  end

  describe 'Validations' do
    # it { should validate_numericality_of :user_id }
    # it { should validate_uniqueness_of(:user_id).scoped_to(:event_id) }
  end
end
