require 'rails_helper'

RSpec.describe "event_memberships/index", type: :view do
  before(:each) do
    assign(:event_memberships, [
      EventMembership.create!(
        :event => nil,
        :user => nil
      ),
      EventMembership.create!(
        :event => nil,
        :user => nil
      )
    ])
  end

  it "renders a list of event_memberships" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
