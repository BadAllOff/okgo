require 'rails_helper'

RSpec.describe Profile, type: :model do
  describe 'Associations' do
    it { should belong_to :user }
  end

  describe 'Validations' do
    it { should validate_presence_of :gender }
    # it { should validate_presence_of :user }
    # it { should validate_uniqueness_of(:user) }

    it do
      should validate_length_of(:firstname).
        is_at_least(1).is_at_most(20)
    end

    it do
      should validate_length_of(:lastname).
        is_at_least(1).is_at_most(20)
    end

    it do
      should validate_length_of(:about).
        is_at_most(3000)
    end

    it do
      should validate_length_of(:credo).
        is_at_least(1).is_at_most(250)
    end

    it do
      should validate_inclusion_of(:gender).
        in_array(['Female', 'Male', 'Other'])
    end

    it do
      should validate_exclusion_of(:firstname).
        in_array(['admin', 'Admin', 'Administrator', 'Moderator', 'moderator', 'админ', 'администратор', 'Админ', 'Администратор', 'Модератор', 'модератор'])
    end

  end
end