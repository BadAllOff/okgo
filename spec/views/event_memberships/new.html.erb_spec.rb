require 'rails_helper'

RSpec.describe "event_memberships/new", type: :view do
  before(:each) do
    assign(:event_membership, EventMembership.new(
      :event => nil,
      :user => nil
    ))
  end

  it "renders new event_membership form" do
    render

    assert_select "form[action=?][method=?]", event_memberships_path, "post" do

      assert_select "input#event_membership_event_id[name=?]", "event_membership[event_id]"

      assert_select "input#event_membership_user_id[name=?]", "event_membership[user_id]"
    end
  end
end
