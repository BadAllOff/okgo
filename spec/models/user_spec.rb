require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { should have_many(:events).dependent(:destroy)}
    it { should have_many(:event_memberships).dependent(:destroy)}
    it { should have_one(:profile).dependent(:destroy)}
    it { should accept_nested_attributes_for (:profile)}
  end
end
