require 'rails_helper'

RSpec.describe 'profiles/edit', type: :view do
  before(:each) do
    @profile = assign(:profile, Profile.create!(
      firstname: 'MyString',
      lastname: 'MyString',
      gender: 'MyString',
      credo: 'MyText',
      user: nil
    ))
  end

  it 'renders the edit profile form' do
    render

    assert_select 'form[action=?][method=?]', profile_path(@profile), 'post' do

      assert_select 'input#profile_firstname[name=?]', 'profile[firstname]'

      assert_select 'input#profile_lastname[name=?]', 'profile[lastname]'

      assert_select 'input#profile_gender[name=?]', 'profile[gender]'

      assert_select 'textarea#profile_credo[name=?]', 'profile[credo]'

      assert_select 'input#profile_user_id[name=?]', 'profile[user_id]'
    end
  end
end
