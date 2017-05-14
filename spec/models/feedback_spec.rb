require 'rails_helper'

RSpec.describe Feedback, type: :model do
  describe 'Associations' do
    it { should belong_to :user }
    it { should have_many(:comments).dependent(:destroy) }
  end

  describe 'Validations' do
    it { should validate_presence_of :user }
    it { should validate_presence_of :status }

    it do
      should validate_length_of(:feedback).
        is_at_least(7).is_at_most(2000)
    end

    it do
      should validate_inclusion_of(:status).
        in_array(['positive', 'negative', 'suggestion'])
    end

  end
end