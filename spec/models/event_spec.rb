require 'rails_helper'

RSpec.describe Event, type: :model do

  let(:event) { FactoryGirl.build :event }
  subject { event }

  describe 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:language) }
    it { should have_many(:memberships).dependent(:destroy) }
  end

  describe 'Validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :description }
    it { should validate_presence_of :starts_at }
    it { should validate_presence_of :ends_at }
    it { should validate_presence_of :max_members }
    it { should validate_presence_of :language }

    context 'when starts_at is the current time, or less than one day before event, or 1 day and more' do
      it do should_not allow_value(DateTime.current).
          for(:starts_at) end

      it do should_not allow_value(DateTime.current + 23.hours).
          for(:starts_at) end
    end

    context 'when starts_at is on 1 day and more before event' do
      it do should allow_value(DateTime.current + 1.day).
          for(:starts_at) end
    end

    context 'when end date is before or on start date' do
      it do should_not allow_value(event.starts_at - 1.minute).
          for(:ends_at) end

      it do should_not allow_value(event.starts_at).
          for(:ends_at) end
    end

    context 'when the end date is after the start date' do
      it do should allow_value(event.starts_at + 1.minute).
          for(:ends_at) end
    end
  end # Validations
end
