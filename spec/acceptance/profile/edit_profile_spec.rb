require 'acceptance/acceptance_helper'

feature 'User edits his own profile ', %q{
  In order to edit my own profile
  As an Authenticated user
} do

  given!(:user) { create(:user) }
  given!(:profile) { create(:profile, user: user) }
  given!(:another_user) { create(:user) }
  given!(:another_user_profile) { create(:profile, user: another_user) }

  describe 'Authenticated user' do
    context 'tries to edit his own profile' do
      before do
        sign_in(user)
        visit edit_profile_path(id: profile.id, locale: I18n.locale)
      end

      scenario 'succeeds with right input' do
        fill_in I18n.t('activerecord.attributes.profile.firstname'), with: 'Antonio'
        fill_in I18n.t('activerecord.attributes.profile.lastname'), with: 'Luciano'
        fill_in I18n.t('activerecord.attributes.profile.about'), with: "I'm an italian singer."
        fill_in I18n.t('activerecord.attributes.profile.credo'), with: 'Vita verde, miamore!'
        choose(I18n.t('activerecord.attributes.profile.gender_male'))
        click_on I18n.t('helpers.submit.update', model: Profile)

        expect(page).to have_content I18n.t('profiles.profile_was_successfully_updated')
        expect(page).to have_content 'Antonio'
        expect(page).to have_content 'Luciano'
        expect(page).to have_content I18n.t('activerecord.attributes.profile.gender_male')
        expect(page).to have_content "I'm an italian singer."

        expect(current_path).to eq profile_path(id: profile.id, locale: I18n.locale)
      end

      scenario 'fails with wrong input' do
        fill_in I18n.t('activerecord.attributes.profile.firstname'), with: ''
        fill_in I18n.t('activerecord.attributes.profile.lastname'), with: ''
        fill_in I18n.t('activerecord.attributes.profile.about'), with: "Can be empty but doesn't matter"
        fill_in I18n.t('activerecord.attributes.profile.credo'), with: ''
        choose(I18n.t('activerecord.attributes.profile.gender_male'))
        click_on I18n.t('helpers.submit.update', model: Profile)

        expect(page).to have_content '3 errors prohibited this profile from being saved'
        expect(page).to have_content 'Firstname is too short (minimum is 1 character)'
        expect(page).to have_content 'Lastname is too short (minimum is 1 character)'
        expect(page).to have_content 'Credo is too short (minimum is 1 character)'
        expect(current_path).to eq profile_path(id: profile.id, locale: I18n.locale)
      end
    end

    context 'tries to edit his own profile' do
      before do
        sign_in(another_user)
      end

      scenario 'fails to see EDIT btn for other users profile' do
        visit edit_profile_path(id: profile.id, locale: I18n.locale)
        expect(current_path).to eq root_path(locale: I18n.locale)
        expect(page).to have_content(I18n.t('devise.failure.already_authenticated'))
      end

      scenario 'fails to EDIT other users profile' do
        visit profile_path(id: profile.id, locale: I18n.locale)
        within("div.box-profile") do
          expect(page).to_not have_link(I18n.t('edit'))
        end
      end
    end
  end
end