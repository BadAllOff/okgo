class WelcomeController < ApplicationController
  before_action :set_profile

  def index
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_profile
    @profile = Profile.where(user_id: current_user).first
  end
end
