require 'rails_helper'

RSpec.describe 'EventMemberships', type: :request do
  describe 'GET /event_memberships' do
    it 'works! (now write some real specs)' do
      get event_memberships_path
      expect(response).to have_http_status(200)
    end
  end
end
