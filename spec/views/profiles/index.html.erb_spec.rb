require 'rails_helper'

RSpec.describe 'profiles/index', type: :view do
  before(:each) do
    assign(:profiles, [
      Profile.create!(
        firstname: 'Firstname',
        lastname: 'Lastname',
        gender: 'Gender',
        credo: 'MyText',
        user: nil
      ),
      Profile.create!(
        firstname: 'Firstname',
        lastname: 'Lastname',
        gender: 'Gender',
        credo: 'MyText',
        user: nil
      )
    ])
  end

  it 'renders a list of profiles' do
    render
    assert_select 'tr>td', text: 'Firstname'.to_s, count: 2
    assert_select 'tr>td', text: 'Lastname'.to_s, count: 2
    assert_select 'tr>td', text: 'Gender'.to_s, count: 2
    assert_select 'tr>td', text: 'MyText'.to_s, count: 2
    assert_select 'tr>td', text: nil.to_s, count: 2
  end
end
