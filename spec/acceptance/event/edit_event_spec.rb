require 'acceptance/acceptance_helper'

feature 'User edits event ', %q{
  In order to edit event
  As an authenticated user
} do

  given(:user) { create(:user) }
  given!(:profile) { create(:profile, user: user) }
  given!(:language) { create(:language) }
  given(:another_user) { create(:user) }
  given!(:another_user_profile) { create(:profile, user: another_user) }
  given!(:event) {create(:event, user: user, language: language)}

  describe 'Authenticated user tries to edit' do
    context 'his own event' do
      before do
        sign_in(user)
        visit events_path(locale: I18n.locale)
        @starts_at = DateTime.current + 25.hours
        @ends_at = DateTime.current + 26.hours
      end

      scenario 'succeed to see edit btn for his event' do
        expect(page).to have_content event.description
        expect(page).to have_content event.title
        within("div#event_#{event.id}") { click_on I18n.t('event_memberships.event_description') }
        within("div#event_#{event.id}") { expect(page).to have_link(I18n.t('edit')) }
      end

      scenario 'succeeds with correct input' do
        within("div#event_#{event.id}") do
          click_on I18n.t('event_memberships.event_description')
          click_on I18n.t('edit')
        end

        fill_in I18n.t('activerecord.attributes.event.title'), with: 'Updated Event title'
        fill_in I18n.t('activerecord.attributes.event.description'), with: 'Updated Event Decription'
        fill_in I18n.t('activerecord.attributes.event.max_members'), with: 66
        fill_in I18n.t('activerecord.attributes.event.address'), with: 'M. Mehdiyev 21 (21 studio)'
        fill_in 'datetimepicker1', with: @starts_at.strftime('%Y-%m-%d %H:%M')
        fill_in 'datetimepicker2', with: @ends_at.strftime('%Y-%m-%d %H:%M')
        within '#event_language_id' do
          find("option[value='2']").click
        end
        click_on I18n.t('helpers.submit.update', model: Event)


        expect(page).to have_content I18n.t('events.event_was_successfully_updated')
        expect(page).to have_content 'Updated Event title'
        expect(page).to have_content 'Updated Event Decription'
        expect(page).to have_content 'M. Mehdiyev 21 (21 studio)'
      end
    end

    context 'other users event' do
      before do
        sign_in(another_user)
        visit events_path(locale: I18n.locale)
      end

      scenario 'fails to see edit btn for his event' do
        expect(page).to have_content event.description
        expect(page).to have_content event.title
        within("div#event_#{event.id}") { click_on I18n.t('event_memberships.event_description') }
        within("div#event_#{event.id}") { expect(page).to_not have_link(I18n.t('edit')) }
      end
    end

  end
end
