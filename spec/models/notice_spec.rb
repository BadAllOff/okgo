require 'rails_helper'

RSpec.describe Notice, type: :model do
  describe 'Associations' do
    it { should belong_to :user }
    it { should belong_to :activity }
  end

  describe 'Validations' do
  end
end
