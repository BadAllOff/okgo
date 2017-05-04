require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { should have_many(:events).dependent(:destroy) }
    it { should have_many(:event_memberships).dependent(:destroy) }
    it { should have_many(:rated_memberships).dependent(:destroy) }
    it { should have_many(:feedbacks).dependent(:destroy) }
    it { should have_many(:notices).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_one(:profile).dependent(:destroy) }
  end

  describe 'Validations' do
    it { should accept_nested_attributes_for :profile }
  end
end
