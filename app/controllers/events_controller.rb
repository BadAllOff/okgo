class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  before_action :set_event, only: [:edit, :update, :destroy, :members]
  before_action :set_count_events, only: [:index]
  before_action :get_events, only: [:index]
  before_action :set_count_memberships, only: [:index]
  before_action :set_page_title

  include Profiled
  include Breadcrumbed
  before_action :set_event_index_breadcrumb, only: [:index, :show, :edit, :new]

  authorize_resource

  def index
    @languages = Language.all.order(events_count: 'desc')
  end

  def show
    @event = Event.where(id: params[:id]).includes(:language, user: [:profile], comments: [user: [:profile]]).first
    add_breadcrumb I18n.t('breadcrumbs.events.show'), event_path(@event)
    build_markers_hash
  end

  # GET /events/new
  def new
    add_breadcrumb I18n.t('breadcrumbs.events.new'), new_event_path
    @event = Event.new
    build_markers_hash
  end

  # GET /events/1/edit
  def edit
    authorize! :update, @event
    build_markers_hash
    add_breadcrumb I18n.t('breadcrumbs.events.edit'), edit_event_path
  end

  # POST /events
  # POST /events.json
  def create
    @event = current_user.events.build(event_params)
    build_markers_hash
    respond_to do |format|
      if @event.save
        @event.create_activity key: 'event.create', owner: current_user
        current_user.follow!(@event)
        format.html { redirect_to @event, flash: { success: I18n.t('events.event_was_successfully_created') }}
      else
        add_breadcrumb I18n.t('breadcrumbs.events.new'), new_event_path
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        @event.create_activity key: 'event.update', owner: current_user
        format.html { redirect_to @event, flash: { success: I18n.t('events.event_was_successfully_updated') }}
      else
        format.html { render :edit }
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
    Follow.remove_followers(@event)

    respond_to do |format|
      format.html { redirect_to events_url, flash: { success: I18n.t('events.event_was_successfully_destroyed') }}
      format.json { head :no_content }
    end
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def set_page_title
    @page_title = I18n.t('page_titles.events')
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def event_params
    params.require(:event).permit(:title, :description, :address, :starts_at, :ends_at, :language_id, :max_members, :latitude, :longitude, :cefrl, :event_bg_image)
  end

  def set_count_events
    @count_events = Event.all.size
  end

  def get_events
    @events = Event.where('starts_at >= ?', Time.zone.now).order(starts_at: :asc).includes(:language, user: [:profile], comments: [:user] ).page(params[:page]).per(10)
  end

  def set_count_memberships
    @count_memberships = EventMembership.all.size
  end

  def set_event_index_breadcrumb
    add_breadcrumb I18n.t('breadcrumbs.events.index'), events_path
  end

  def build_markers_hash
    @hash = Gmaps4rails.build_markers(@event) do |event, marker|
      marker.lat event.latitude ||= Rails.application.secrets.default_latitude
      marker.lng event.longitude ||= Rails.application.secrets.default_longitude
    end
  end
end
