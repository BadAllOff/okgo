require 'rails_helper'

RSpec.describe Profile, type: :model do

  let(:profile) { FactoryGirl.build :profile }
  subject { profile }

  describe 'Associations' do
    it {should belong_to(:user)}
  end

  describe 'Validations' do
    it { should validate_presence_of :firstname}
    it { should validate_presence_of :lastname}
    it { should validate_presence_of :gender}
    it { should validate_inclusion_of(:gender).in_array(['Female', 'Male', 'Other']) }
    it { should validate_uniqueness_of(:user_id) }
  end # Validations

end
