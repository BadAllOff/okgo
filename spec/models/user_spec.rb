require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { should have_many(:events).dependent(:destroy)}
    it { should have_many(:event_memberships).dependent(:destroy)}
    it { should have_one(:profile).dependent(:destroy)}
    it { should accept_nested_attributes_for (:profile)}
  end

  describe 'Validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :password }
  end # Validations

  # it "create new profile in database for user" do
  #   user = FactoryGirl.build(:user)
  #   Profile.should_receive(:create).with(user_id: user.id)
  #   user.save
  # end
end
