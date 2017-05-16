require 'acceptance/acceptance_helper'

feature 'User deletes feedback ', %q{
  In order to delete feedback
  As an Authenticated user
} do

  given(:user) { create(:user) }
  given(:another_user) { create(:user) }
  given!(:profile) { create(:profile, user: user) }
  given!(:another_user_profile) { create(:profile, user: another_user) }
  given!(:feedback) { create(:feedback, user: user) }

  describe 'Authenticated user' do
    context 'tries to delete his feedback' do

      before do
        sign_in(user)
        visit feedbacks_path(locale: I18n.locale)
      end

      scenario 'succeeds' do
        within("div#feedback_#{feedback.id}") { click_on I18n.t('destroy') }

        expect(current_path).to eq feedbacks_path(locale: I18n.locale)
        expect(page).to have_content I18n.t('feedbacks.feedback_was_successfully_destroyed')
        expect(page).to_not have_content feedback.feedback
      end
    end

    context 'tries to delete other users feedback' do

      before do
        sign_in(another_user)
        visit feedbacks_path(locale: I18n.locale)
      end

      scenario 'fails' do
        within("div#feedback_#{feedback.id}") { expect(page).to_not have_link(I18n.t('destroy')) }
        expect(page).to have_content feedback.feedback
      end

    end
  end
end
