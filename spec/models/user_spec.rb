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

  describe '#role' do
    let(:role) { [:guest, :user, :admin] }

    it 'has the right index' do
      role.each_with_index do |item, index|
        expect(User.roles[item]).to eq index
      end
    end
  end

  it "creates new profile in database for user just after registartion" do
    user = FactoryGirl.build(:user)
    expect(Profile).to receive(:create).with(eventual_value { { user_id: user.id } })
    user.save

    expect(user.user?).to be_truthy
    expect(user.guest?).to be_falsey
    expect(user.admin?).to be_falsey
  end
end
