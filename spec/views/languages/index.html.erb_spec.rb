require 'rails_helper'

RSpec.describe "languages/index", type: :view do
  before(:each) do
    assign(:languages, [
      Language.create!(
        :description => "Description"
      ),
      Language.create!(
        :description => "Description"
      )
    ])
  end

  it "renders a list of languages" do
    render
    assert_select "tr>td", :text => "Description".to_s, :count => 2
  end
end
