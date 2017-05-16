require 'acceptance/acceptance_helper'

feature 'User edits his own feedback ', %q{
  In order to edit my his own feedback
  As an Authenticated user
} do

  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given!(:profile) { create(:profile, user: user) }
  given!(:another_user_profile) { create(:profile, user: another_user) }
  given!(:feedback) { create(:feedback, user: user) }

  describe 'Authenticated user' do
    context 'tries to edit his own feedback' do

      before do
        sign_in(user)
        visit feedbacks_path(locale: I18n.locale)
        within("div#feedback_#{feedback.id}") { click_on I18n.t('edit') }
      end

      scenario 'succeeds with right input' do
        within '#feedback_status' do
          find("option[value='positive']").click
        end
        fill_in I18n.t('activerecord.attributes.feedback.feedback'), with: 'This is updated feedback'
        click_on I18n.t('helpers.submit.update', model: Feedback)

        expect(page).to have_content I18n.t('feedbacks.feedback_was_successfully_updated')
        expect(page).to have_content 'This is updated feedback'
        expect(current_path).to eq feedback_path(id: feedback, locale: I18n.locale)
      end

      scenario 'fails with no or wrong input' do
        within '#feedback_status' do
          find("option[value='positive']").click
        end
        fill_in I18n.t('activerecord.attributes.feedback.feedback'), with: 'ERROR'
        click_on I18n.t('helpers.submit.update', model: Feedback)

        expect(current_path).to eq feedback_path(id: feedback, locale: I18n.locale)
        expect(page).to have_content 'Your feedback or suggestion is too short (minimum is 7 characters)'
      end

    end

    context 'tries to edit other users feedback' do

      before do
        sign_in(another_user)
        visit feedbacks_path(locale: I18n.locale)
      end

      scenario 'fails to see edit btn' do
        within("div#feedback_#{feedback.id}") { expect(page).to_not have_link(I18n.t('edit')) }
        expect(page).to have_content feedback.feedback
      end
    end
  end
end
