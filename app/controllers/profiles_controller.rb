class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile, only: [:show, :edit, :update]
  # before_action :set_or_create_profile, only: [:index, :show, :edit, :update]
  before_action :set_page_title

  include Breadcrumbed
  before_action :set_profile_index_breadcrumb, only: [:index, :show, :edit]

  authorize_resource

  #
  # # GET /profiles
  # # GET /profiles.json
  def index
    @profiles = Profile.all.limit(10).includes(:user)
  end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
    memberships = EventMembership.where(user: @profile.user, attended: true).pluck(:id)
    rated_memberships = RatedMembership.where(event_membership: memberships).includes(event_membership: [:event])

    @r_activity_lvl, @r_labels, @r_lang_lvl = [], [], []

    rated_memberships.each do |rate|
        @r_labels << rate.event_membership.event.title
        @r_lang_lvl << rate.language_level
        @r_activity_lvl << rate.activity_level
    end
  end

  # GET /profiles/1/edit
  def edit
    add_breadcrumb I18n.t('breadcrumbs.profiles.edit'), edit_profile_path(@profile)
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to @profile, notice: 'Profile was successfully updated.' }
        format.json { render :index, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    # def set_or_create_profile
    #   @profile = Profile.where(user_id: current_user).first_or_create!
    # end

    def set_profile
      @profile = Profile.includes(:user).find(params[:id])
    end

    def set_activitie
      @activitie = PublicActivity::Activity.where(owner_type: User, owner_id: params[:id]).order('created_at desc')
    end

    def set_page_title
      @page_title = I18n.t('page_titles.profiles')
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:firstname, :lastname, :gender, :credo, :about, :photo, :cover_image)
    end

    def set_profile_index_breadcrumb
      add_breadcrumb I18n.t('breadcrumbs.profiles.index'), profiles_path
    end
end
