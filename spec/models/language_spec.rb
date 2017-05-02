require 'rails_helper'

RSpec.describe Language, type: :model do
  describe 'Associations' do
    it { should have_many(:events) }
    it { should have_many(:rated_memberships) }
  end

  describe 'Validations' do
    it { should validate_presence_of :description }
  end
end
