class EventMembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:join, :leave]
  before_action :set_event_membership, only: [:leave]
  before_action :set_page_title

  include Profiled
  include Breadcrumbed
  before_action :set_membership_index_breadcrumb, only: [:index, :join, :leave]

  authorize_resource

  def index
    @event_memberships =  EventMembership.where(user: current_user).order('created_at')
  end

  def join
    @event_membership = EventMembership.new(user: current_user, event: @event)
      if @event_membership.save
        redirect_to @event, notice: t('events.you_have_joined_to_the_event')
      else
        redirect_to @event, alert: t('events.something_went_wrong')
      end
  end

  def leave
    @event_membership.destroy if !@event_membership.nil?
    redirect_to events_url, notice: t('events.you_have_left_the_event')
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
