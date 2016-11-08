class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_or_create_profile, only: [ :show, :edit, :update ]
  #
  # # GET /profiles
  # # GET /profiles.json
  # def index
  # end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/1/edit
  def edit
  end
  #
  # # POST /profiles
  # # POST /profiles.json
  # def create
  #   @profile = Profile.new(profile_params)
  #   @profile.user = current_user
  #
  #   respond_to do |format|
  #     if @profile.save
  #       format.html { redirect_to @profile, notice: 'Profile was successfully created.' }
  #       format.json { render :show, status: :created, location: @profile }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @profile.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

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
    def set_or_create_profile
      @profile = Profile.where(user_id: current_user).first_or_create!
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:firstname, :lastname, :gender, :credo, :photo)
    end
end
