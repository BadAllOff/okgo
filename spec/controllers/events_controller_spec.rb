require 'rails_helper'

RSpec.describe EventsController, type: :controller do

  describe 'GET #index' do

    event1 = FactoryGirl.create(:event)
    event2 = FactoryGirl.create(:event)

    it '- populates an array of all events' do
      get :index
      expect(assigns(:events)).to include(event1, event2)
    end

    it '- renders index view' do
      get :index
      expect(response).to render_template :index
    end
  end

end