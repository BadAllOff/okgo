class ApplicationController < ActionController::Base
  include PublicActivity::StoreController
  before_action :set_locale

  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :exception


  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) {|u|
      u.permit(:email, :password, profile_attributes: [ :firstname, :lastname, :gender])}
  end

  private

  def set_locale
    if params[:locale].present?
      if I18n.available_locales.include?(params[:locale].to_sym)
        I18n.locale = params[:locale]
      else
        flash[:notice] = "#{params[:locale]} translation not available"
        logger.error flash[:notice]
      end
    elsif
    request.env['HTTP_ACCEPT_LANGUAGE'] == 'en'
      I18n.locale = 'en'
    end
    # Можно использовать для установленных пользователем языков в настройках Аккаунта
    # current_user.locale
    # request.env["HTTP_ACCEPT_LANGUAGE"]
  end

  def default_url_options(options = {})
    { locale: I18n.locale }
  end
end
