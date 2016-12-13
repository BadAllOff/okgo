require 'rails_helper'

RSpec.describe EventMembership, type: :model do

  describe 'Associations' do
    it {should belong_to(:user)}
    it {should belong_to(:event)}
  end

  describe 'Validations' do
    # it { should validate_uniqueness_of(:user_id).scoped_to(:event_id) }
  end # Validations

end
