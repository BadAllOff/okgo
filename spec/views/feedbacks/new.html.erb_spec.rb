require 'rails_helper'

RSpec.describe "feedbacks/new", type: :view do
  before(:each) do
    assign(:feedback, Feedback.new(
      :user => nil,
      :feedback => "MyText"
    ))
  end

  it "renders new feedback form" do
    render

    assert_select "form[action=?][method=?]", feedbacks_path, "post" do

      assert_select "input#feedback_user_id[name=?]", "feedback[user_id]"

      assert_select "textarea#feedback_feedback[name=?]", "feedback[feedback]"
    end
  end
end
