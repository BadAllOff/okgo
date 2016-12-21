class EventMembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:join, :leave]
  before_action :set_event_membership, only: [:leave]
  before_action :set_page_title

  include Profiled
  include Breadcrumbed
  before_action :set_membership_index_breadcrumb, only: [ :join, :leave, :as_tutor, :as_member]

  authorize_resource

  def join
    @event_membership = EventMembership.new(user: current_user, event: @event)
      if @event_membership.event.user != @event_membership.user && @event_membership.save
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

    @future_events = Event.where('(user_id= ? AND starts_at> ?)', current_user.id, Time.zone.now).order('starts_at')
    @past_events = Event.where('(user_id= ? AND starts_at< ?)', current_user.id, Time.zone.now).order('starts_at')
  end

  def as_member
    add_breadcrumb I18n.t('breadcrumbs.event_memberships.as_member'), as_member_event_memberships_path

    @future_event_memberships = EventMembership.joins(:event).where('(event_memberships.user_id= ? AND events.starts_at> ?)', current_user.id, Time.zone.now).includes(:event)
    @past_event_memberships = EventMembership.joins(:event).where('(event_memberships.user_id= ? AND events.starts_at< ?)', current_user.id, Time.zone.now).includes(:event)
  end

  private
    def set_membership_index_breadcrumb
      add_breadcrumb I18n.t('breadcrumbs.event_memberships.index'), event_memberships_path
    end

    def set_event
      @event = Event.find(params[:event_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_event_membership
      @event_membership = EventMembership.where(user: current_user, event: @event).first
    end

    def set_page_title
      @page_title = I18n.t('page_titles.event_memberships')
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_membership_params
      params.require(:event_membership).permit(:event_id, :user_id)
    end
end
