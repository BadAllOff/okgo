require 'acceptance/acceptance_helper'

feature 'User creates event ', %q{
  In order to create event
  As an user
} do

  given(:user) { create(:user) }
  given!(:profile) { create(:profile, user: user) }


  describe 'Authenticated user' do
    context 'tries to create new event' do

      before do
        sign_in(user)
        visit new_event_path(locale: I18n.locale)

        @starts_at = DateTime.current + 25.hours
        @ends_at = DateTime.current + 26.hours
      end

      scenario 'fails with no or wrong input' do

        fill_in I18n.t('activerecord.attributes.event.title'), with: 'Event title'
        fill_in I18n.t('activerecord.attributes.event.description'), with: ''
        fill_in I18n.t('activerecord.attributes.event.max_members'), with: 10
        fill_in I18n.t('activerecord.attributes.event.address'), with: 'A. Akhundov 21 (21 studio)'
        click_on I18n.t('helpers.submit.create', model: Event)

        expect(page).to have_content '3 errors prohibited this event from being saved'
        expect(page).to have_content 'Description is too short (minimum is 10 characters)'
        expect(page).to have_content 'Starts at неверный формат даты и времени'
        expect(page).to have_content 'Ends at неверный формат даты и времениS'
        expect(current_path).to eq events_path(locale: I18n.locale)
      end

      scenario 'succeeds with correct input' do
        # save_and_open_page
        within '#event_language_id' do
          find("option[value='1']").click
        end

        fill_in I18n.t('activerecord.attributes.event.title'), with: 'Event title'
        fill_in I18n.t('activerecord.attributes.event.description'), with: 'Event Decription'
        fill_in I18n.t('activerecord.attributes.event.max_members'), with: 10
        fill_in I18n.t('activerecord.attributes.event.address'), with: 'A. Akhundov 21 (21 studio)'
        fill_in 'datetimepicker1', with: @starts_at.strftime('%Y-%m-%d %H:%M')
        fill_in 'datetimepicker2', with: @ends_at.strftime('%Y-%m-%d %H:%M')
        click_on I18n.t('helpers.submit.create', model: Event)


        expect(page).to have_content I18n.t('events.event_was_successfully_created')
        expect(page).to have_content 'Event title'
        expect(page).to have_content 'Event Decription'
        expect(page).to have_content 'A. Akhundov 21 (21 studio)'
      end
    end
  end

end
