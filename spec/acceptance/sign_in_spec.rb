require 'acceptance/acceptance_helper'

feature 'User sign in', %q{
  In order to be able to use services
  As an user
  I want to be able to sign in
} do

  scenario 'Registered user tries to sign in' do
    user = User.create!(email: 'testUser@text.com', password: '123456qweQWE#$')
    user.confirm
    user.save
    profile = user.build_profile(gender: 'Male', firstname: 'Profilename', lastname: 'profilelast', credo: 'vita vitavita')
    profile.save

    visit new_user_session_path(locale: I18n.locale)
    fill_in I18n.t('activerecord.attributes.user.email'), with: user.email
    fill_in I18n.t('activerecord.attributes.user.password'), with: '123456qweQWE#$'
    click_on I18n.t('sign_in')

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
