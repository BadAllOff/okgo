require 'rails_helper'

RSpec.describe Language, type: :model do
  describe 'Associations' do

  end

  describe 'Validations' do
    it { should validate_presence_of :description }
    # it { expect(Language.new()).to_not  be_valid }
  end
end
