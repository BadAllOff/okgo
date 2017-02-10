class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :set_event, only: [:edit, :update, :destroy, :members]
  before_action :set_count_events, only: [:index]
  before_action :set_count_memberships, only: [:index]
  before_action :set_page_title

  include Profiled
  include Breadcrumbed
  before_action :set_event_index_breadcrumb, only: [:index, :show, :edit, :new]

  authorize_resource

  # GET /events  before_action :set_page_title

  # GET /events.json
  def index
    @events = Event.where('starts_at >= ?', Time.zone.now).order(starts_at: :asc).includes(:language, user: [:profile], comments: [:user] ).page(params[:page]).per(10)
    @languages = Language.all.order(events_count: 'desc')
  end

  # GET /events/1
  # GET /events/1.json
  def show
    @event = Event.where(id: params[:id]).includes(:language, user: [:profile], comments: [user: [:profile]]).first
    add_breadcrumb I18n.t('breadcrumbs.events.show'), event_path(@event)
    @hash = Gmaps4rails.build_markers(@event) do |event, marker|
      marker.lat event.latitude || Rails.application.secrets.default_latitude
      marker.lng event.longitude || Rails.application.secrets.default_longitude
    end
  end

  # GET /events/new
  def new
    add_breadcrumb I18n.t('breadcrumbs.events.new'), new_event_path
    @event = Event.new
    @hash = Gmaps4rails.build_markers(@event) do |event, marker|
      marker.lat event.latitude || Rails.application.secrets.default_latitude
      marker.lng event.longitude || Rails.application.secrets.default_longitude
    end
  end

  # GET /events/1/edit
  def edit
    authorize! :update, @event
    @hash = Gmaps4rails.build_markers(@event) do |event, marker|
      marker.lat event.latitude || Rails.application.secrets.default_latitude
      marker.lng event.longitude || Rails.application.secrets.default_longitude
    end
    add_breadcrumb I18n.t('breadcrumbs.events.edit'), edit_event_path
  end

  # POST /events
  # POST /events.json
  def create
    @event = current_user.events.build(event_params)
    @hash = Gmaps4rails.build_markers(@event) do |event, marker|
      marker.lat event.latitude || Rails.application.secrets.default_latitude
      marker.lng event.longitude || Rails.application.secrets.default_longitude
    end
    respond_to do |format|
      if @event.save
        format.html { redirect_to @event, notice: 'Event was successfully created.' }
        format.json { render :show, status: :created, location: @event }
      else
        format.html { render :new }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def members
    @members = EventMembership.where(event_id: params[:id]).includes(:profile)
    respond_to do |format|
      format.json { render 'members.json.jbuilder', status: :ok, layout: false }
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_event
    @event = Event.find(params[:id])
  end

  def set_page_title
    @page_title = I18n.t('page_titles.events')
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    if action_name == 'not_usual_action'
      params.require(:event).permit(:title, :description, :address, :starts_at, :ends_at, :language_id, :max_members, :latitude, :longitude)
    else
      params.require(:event).permit(:title, :description, :address, :starts_at, :ends_at, :language_id, :max_members, :latitude, :longitude)
    end
  end

  def set_count_events
    @count_events = Event.all.size
    # @count_events = Event.where('starts_at > ?', Time.zone.today).size
  end

  def set_count_memberships
    @count_memberships = EventMembership.all.size
    # @count_memberships = Event.joins(:memberships).where('starts_at > ?', Time.zone.today).size
  end

  def set_event_index_breadcrumb
    add_breadcrumb I18n.t('breadcrumbs.events.index'), events_path
  end
end
