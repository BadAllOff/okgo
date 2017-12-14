module AcceptanceMacros
  # метод происходит на уровне сценария а не класса
  def sign_in(user)
    visit new_user_session_path(locale: I18n.locale)
    fill_in I18n.t('activerecord.attributes.user.email'), with: user.email
    fill_in I18n.t('activerecord.attributes.user.password'), with: user.password
    click_on I18n.t('sign_in')
  end
end
