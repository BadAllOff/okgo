require 'acceptance/acceptance_helper'

feature 'User creates feedback ', %q{
  In order to create feedback
  As an Authenticated user
} do

  given(:user) { create(:user) }
  given!(:profile) { create(:profile, user: user) }

  describe 'Authenticated user' do
    context 'tries to create new feedback' do

      before do
        sign_in(user)
        visit feedbacks_path(locale: I18n.locale)
        click_on I18n.t('feedbacks.feedback.leave_feedback')
      end

      scenario 'succeeds with right input' do
        within '#feedback_status' do
          find("option[value='positive']").click
        end
        fill_in I18n.t('activerecord.attributes.feedback.feedback'), with: 'This is new feedback'
        click_on I18n.t('helpers.submit.create', model: Feedback)

        # expect(current_path).to eq feedback_path(id: feedback, locale: I18n.locale)
        expect(page).to have_content I18n.t('feedbacks.feedback_was_successfully_created')
        expect(page).to have_content 'This is new feedback'
      end

      scenario 'fails with no or wrong input' do
        within '#feedback_status' do
          find("option[value='positive']").click
        end
        fill_in I18n.t('activerecord.attributes.feedback.feedback'), with: ''
        click_on I18n.t('helpers.submit.create', model: Feedback)

        # expect(current_path).to eq feedback_path(id: feedback, locale: I18n.locale)
        expect(page).to have_content 'Your feedback or suggestion is too short (minimum is 7 characters)'
        expect(current_path).to eq feedbacks_path(locale: I18n.locale)
      end

    end
  end
end
