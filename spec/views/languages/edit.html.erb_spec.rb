require 'rails_helper'

RSpec.describe "languages/edit", type: :view do
  before(:each) do
    @language = assign(:language, Language.create!(
      :description => "MyString"
    ))
  end

  it "renders the edit language form" do
    render

    assert_select "form[action=?][method=?]", language_path(@language), "post" do

      assert_select "input#language_description[name=?]", "language[description]"
    end
  end
end
