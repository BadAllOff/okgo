require 'rails_helper'

RSpec.describe "feedbacks/edit", type: :view do
  before(:each) do
    @feedback = assign(:feedback, Feedback.create!(
      :user => nil,
      :feedback => "MyText"
    ))
  end

  it "renders the edit feedback form" do
    render

    assert_select "form[action=?][method=?]", feedback_path(@feedback), "post" do

      assert_select "input#feedback_user_id[name=?]", "feedback[user_id]"

      assert_select "textarea#feedback_feedback[name=?]", "feedback[feedback]"
    end
  end
end
