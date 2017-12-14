require 'rails_helper'

RSpec.describe RatedMembership, type: :model do
  describe 'Associations' do
    it { should belong_to :user }
    it { should belong_to :event_membership }
    it { should belong_to :language }
  end

  describe 'Validations' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :event_membership }
    it { should validate_presence_of :language }
    it { should validate_presence_of :rated_member_id }
    it { should validate_presence_of :language_level }
    it { should validate_presence_of :activity_level }
    it { should validate_numericality_of(:language_level) }
    it { should validate_numericality_of(:activity_level) }
  end
end