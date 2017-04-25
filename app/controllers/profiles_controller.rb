class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :edit, :update]
  before_action :set_page_title

  include Breadcrumbed
  before_action :set_profile_index_breadcrumb, only: [:index, :show, :edit]

  authorize_resource

  def index
    @profiles = Profile.all.includes(:user).page(params[:page]).per(12)
  end

  def show
    memberships = EventMembership.where(user: @profile.user, attended: true).pluck(:id)
    rated_memberships = RatedMembership.where(event_membership: memberships).includes(event_membership: [:event])

    set_profile_chart_data(rated_memberships)
  end

  def edit
    add_breadcrumb I18n.t('breadcrumbs.profiles.edit'), edit_profile_path(@profile)
  end

  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  private

  def set_profile
    @profile = Profile.includes(:user).find(params[:id])
  end

  def set_activitie
    @activitie = PublicActivity::Activity.where(owner_type: User, owner_id: params[:id]).order('created_at desc')
  end

  def set_page_title
    @page_title = I18n.t('page_titles.profiles')
  end

  def profile_params
    params.require(:profile).permit(:firstname, :lastname, :gender, :credo, :about, :photo, :cover_image)
  end

  def set_profile_chart_data(rated_memberships)
    @r_activity_lvl, @r_labels, @r_lang_lvl = [], [], []

    rated_memberships.each do |rate|
      @r_labels << rate.event_membership.event.title
      @r_lang_lvl << rate.language_level
      @r_activity_lvl << rate.activity_level
    end
  end

  def set_profile_index_breadcrumb
    add_breadcrumb I18n.t('breadcrumbs.profiles.index'), profiles_path
  end
end
