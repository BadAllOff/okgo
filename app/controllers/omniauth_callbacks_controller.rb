class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  before_action :oauth, except: :failure

  def facebook
    render json: request.env['omniauth.auth']
  end
  #
  # def twitter
  # end
  #
  # def vkontakte
  # end
  #
  # def github
  # end

  def finish_registration
  end

  def failure
    flash['alert'] = 'Authentication failed, please check your input and try again.'
    redirect_to root_url
  end

  private

  def oauth
    user = User.find_for_oauth(auth)
    if user && user.persisted?
      sign_in_and_redirect user, event: :authentication
      set_flash_message(:notice, :success, kind: auth.provider.capitalize) if is_navigational_format?
    else
      session[:provider] = auth.provider
      session[:uid] = auth.uid
      render 'omniauth/prompt_additional_data', locals: { auth: auth, user: user, profile: user.profile}
    end
  end

  def auth
    request.env['omniauth.auth'] || OmniAuth::AuthHash.new(provider: session[:provider], uid: session[:uid], info: { email: params[:user][:email], first_name: params[:profile][:firstname], last_name: params[:profile][:lastname] })
  end

end
