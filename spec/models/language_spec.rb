require 'rails_helper'

RSpec.describe Language, type: :model do
  describe 'Associations' do
    it {should have_many(:events)}
  end

end
