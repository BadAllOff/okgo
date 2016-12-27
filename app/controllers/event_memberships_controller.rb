class EventMembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:join, :leave]
  before_action :set_event_membership, only: [:leave]
  before_action :set_page_title
  before_action :get_users_membership, only: [:member_attended, :member_not_attended]

  include Profiled
  include Breadcrumbed
  before_action :set_membership_index_breadcrumb, only: [ :join, :leave, :as_tutor, :as_member]

  # authorize_resource

  def join
    @event_membership = EventMembership.new(user: current_user, event: @event)
      if @event.joinable?(@event_membership) && @event_membership.save
        redirect_to @event, notice: t('events.you_have_joined_to_the_event')
      else
        redirect_to @event, alert: t('events.something_went_wrong')
      end
  end

  def leave
    @event_membership.destroy if !@event_membership.nil?
    redirect_to events_url, notice: t('events.you_have_left_the_event')
  end

  def as_tutor
    add_breadcrumb I18n.t('breadcrumbs.event_memberships.as_tutor'), as_tutor_event_memberships_path

    @future_events = Event.where('(user_id= ? AND starts_at> ?)', current_user.id, Time.zone.now).order('starts_at').includes(:language, user: [:profile], memberships: [user: [:profile]])
    @past_events = Event.where('(user_id= ? AND starts_at< ?)', current_user.id, Time.zone.now).order('starts_at').includes(:language, user: [:profile], memberships: [user: [:profile]])
  end

  def as_member
    add_breadcrumb I18n.t('breadcrumbs.event_memberships.as_member'), as_member_event_memberships_path

    @future_event_memberships = EventMembership.joins(:event).where('(event_memberships.user_id= ? AND events.starts_at> ?)', current_user.id, Time.zone.now).includes(event: [:user, :language, memberships: [user: [:profile]]])
    @past_event_memberships = EventMembership.joins(:event).where('(event_memberships.user_id= ? AND events.starts_at< ?)', current_user.id, Time.zone.now).includes(event: [:user, :language, memberships: [user: [:profile]]])
  end

  def member_attended
    @event = Event.find(@event_membership.event)
    if @event && current_user.author_of?(@event)
      if @event_membership  && @event_membership.event.ends_at < Time.zone.now
        @event_membership.update_columns( attended: true, marked: true)
        # @event_membership.save
        # respond_to do |f|
        #   f.js { render layout: false, content_type: 'text/javascript' }
        # end
        # render layout: false
      end
    end
  end

  def member_not_attended
    @event = Event.find(@event_membership.event)
    if @event && current_user.author_of?(@event)
      if @event_membership  && @event_membership.event.ends_at < Time.zone.now
        @event_membership.update_columns( attended: false, marked: false)
        # @event_membership.save
        render json: @event_membership
      end
    end
  end



  private
    def set_membership_index_breadcrumb
      add_breadcrumb I18n.t('breadcrumbs.event_memberships.index'), '#'
    end

    def set_event
      @event = Event.find(params[:event_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_event_membership
      @event_membership = EventMembership.where(user: current_user, event: @event).first
    end

    def get_users_membership
      @event_membership = EventMembership.find(params[:id])
    end

    def set_page_title
      @page_title = I18n.t('page_titles.event_memberships')
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_membership_params
      params.require(:event_membership).permit(:event_id, :attended)
    end
end
