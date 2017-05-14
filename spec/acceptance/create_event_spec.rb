require 'acceptance/acceptance_helper'

feature 'User creates event ', %q{
  In order to create event
  As an user
} do

  given(:user) { create(:user) }
  given!(:profile) { create(:profile, user: user) }


  describe 'Authenticated user' do
    context 'creates new event' do

      before do
        sign_in(user)
        visit profile_path(id: profile, locale: I18n.locale)
      end

      scenario 'with wrong data' do
        visit new_event_path(locale: I18n.locale)

        fill_in I18n.t('activerecord.attributes.event.title'), with: 'Event title'
        fill_in I18n.t('activerecord.attributes.event.description'), with: 'Event Decription'
        fill_in I18n.t('activerecord.attributes.event.max_members'), with: 10
        fill_in I18n.t('activerecord.attributes.event.address'), with: 'A. Akhundov 21 (21 studio)'

        click_on I18n.t('helpers.submit.create', model: Event)

        save_and_open_page

        expect(page).to have_content I18n.t'errors.messages.blank'
        expect(current_path).to eq new_event_path(locale: I18n.locale)

      end
    end
  end

end
