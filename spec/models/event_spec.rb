require 'rails_helper'

RSpec.describe Event, type: :model do
  describe 'Associations' do
    it { should belong_to :user }
    it { should belong_to :language }
    it { should have_many(:memberships).dependent(:destroy) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:activities).dependent(:destroy) }
  end

  describe 'Validations' do
    it { should validate_presence_of :max_members }
    it { should validate_presence_of :language }
    it { should validate_numericality_of(:latitude) }
    it { should validate_numericality_of(:longitude) }

    it do
      should validate_length_of(:title).
          is_at_least(4).is_at_most(140)
    end

    it do
      should validate_length_of(:description).
          is_at_least(10).is_at_most(3000)
    end

    it do
      should validate_length_of(:address).
          is_at_least(10).is_at_most(255)
    end
  end
end
