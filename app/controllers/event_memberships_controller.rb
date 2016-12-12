class EventMembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:join, :leave]
  before_action :set_event_membership, only: [:leave]

  include Profiled

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
    respond_to do |format|
      format.html { redirect_to events_url, notice: t('events.you_have_left_the_event') }
      format.json { head :no_content }
    end
    #
    # if @event_membership.delete
    #   format.html { redirect_to @event, notice: 'You left the event' }
    # else
    #   format.html { redirect_to @event, alert: 'Something went wrong. Try later.' }
    # end
  end

  private
    def set_event
      @event = Event.find(params[:event_id])
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_event_membership
      @event_membership = EventMembership.where(user: current_user, event: @event).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_membership_params
      params.require(:event_membership).permit(:event_id, :user_id)
    end
end
