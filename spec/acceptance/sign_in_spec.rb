require 'acceptance/acceptance_helper'

feature 'User sign in', %q{
  In order to be able to use services
  As an user
  I want to be able to sign in
} do

  given(:user) { create(:user) }
  given!(:profile) { create(:profile, user: user) }

  scenario 'Registered user tries to sign in' do
    sign_in(user)

    expect(page).to have_content I18n.t'devise.sessions.signed_in'
    expect(current_path).to eq root_path(locale: I18n.locale)
  end

  scenario 'Non-registered user try to sign in' do
    visit new_user_session_path(locale: I18n.locale)
    fill_in I18n.t('activerecord.attributes.user.email'), with: 'not_a_user@text.com'
    fill_in I18n.t('activerecord.attributes.user.password'), with: 'not_a_password'
    click_on I18n.t('sign_in')

    expect(page).to have_content I18n.t'devise.failure.not_found_in_database'
    expect(current_path).to eq new_user_session_path(locale: I18n.locale)
  end

end
