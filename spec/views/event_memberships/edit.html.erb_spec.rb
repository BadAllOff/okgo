require 'rails_helper'

RSpec.describe "event_memberships/edit", type: :view do
  before(:each) do
    @event_membership = assign(:event_membership, EventMembership.create!(
      :event => nil,
      :user => nil
    ))
  end

  it "renders the edit event_membership form" do
    render

    assert_select "form[action=?][method=?]", event_membership_path(@event_membership), "post" do

      assert_select "input#event_membership_event_id[name=?]", "event_membership[event_id]"

      assert_select "input#event_membership_user_id[name=?]", "event_membership[user_id]"
    end
  end
end
