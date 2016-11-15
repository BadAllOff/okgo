require 'rails_helper'

RSpec.describe "languages/new", type: :view do
  before(:each) do
    assign(:language, Language.new(
      :description => "MyString"
    ))
  end

  it "renders new language form" do
    render

    assert_select "form[action=?][method=?]", languages_path, "post" do

      assert_select "input#language_description[name=?]", "language[description]"
    end
  end
end
