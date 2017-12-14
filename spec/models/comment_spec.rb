require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Associations' do
    it { should belong_to :user }
    it { should belong_to :commentable }
  end

  describe 'Validations' do
    it { should validate_presence_of :body }

    it do
      should validate_length_of(:body).
        is_at_most(2000)
    end

  end
end