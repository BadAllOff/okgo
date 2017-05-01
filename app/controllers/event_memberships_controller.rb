class EventMembershipsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event, only: [:join, :leave, :show_event_members]
  before_action :get_membership_for_current_user, only: [:leave]
  before_action :set_page_title
  before_action :get_users_membership, only: [:member_attended, :member_not_attended, :rate_member]

  include Profiled
  include Notified
  include Breadcrumbed
  before_action :set_membership_index_breadcrumb, only: [ :join, :leave, :as_tutor, :as_member]

  # authorize_resource

  def join
    @event_membership = EventMembership.new(user: current_user, event: @event)
    respond_to do |format|
      if @event.joinable?(@event_membership) && @event_membership.save
        # notifie followers
        activity = @event.create_activity key: 'event.join', owner: current_user
        notify_followers(activity, @event.followers(User))
        # then add user to event
        current_user.follow!(@event)

        format.html { redirect_to @event, notice: t('events.you_have_joined_to_the_event') }
        format.json { render 'joined.json.jbuilder', status: :ok }
      else
        @error_msg =
        format.html { redirect_to @event, alert: t('events.something_went_wrong') }
        format.json { render 'shared/alert.json.jbuilder', status: :ok }
      end
    end
  end

  def leave
    @event_membership.destroy if !@event_membership.nil?
    respond_to do |format|
      # take user out of event
      current_user.unfollow!(@event)
      # notifie followers
      activity = @event.create_activity key: 'event.leave', owner: current_user
      notify_followers(activity, @event.followers(User))

      format.html { redirect_to events_url, notice: t('events.you_have_left_the_event') }
      format.json { render 'leaved.json.jbuilder', status: :ok }
    end
  end

  def show_event_members
    @memberships = EventMembership.where(event: @event).includes(:user, :profile, :rated_memberships)
    # render another partial for not finished events
    render partial: 'event_memberships/event/as_tutor_members_list', locals: { memberships: @memberships }, layout: false
  end

  def as_tutor
    add_breadcrumb I18n.t('breadcrumbs.event_memberships.as_tutor'), as_tutor_event_memberships_path

    @future_events = Event.where('(user_id= ? AND starts_at> ?)', current_user.id, Time.zone.now).includes(:language, user: [:profile]).order('starts_at ASC').page(params[:page]).per(10)
    @past_events = Event.where('(user_id= ? AND starts_at< ?)', current_user.id, Time.zone.now).includes(:language, user: [:profile]).order('starts_at DESC').page(params[:page]).per(10)
  end

  def as_member
    add_breadcrumb I18n.t('breadcrumbs.event_memberships.as_member'), as_member_event_memberships_path

    @future_event_memberships = EventMembership.joins(:event).where('(event_memberships.user_id= ? AND events.starts_at> ?)', current_user.id, Time.zone.now).includes(event: [:user, :language, comments: [:user]]).page(params[:page]).per(10)
    @past_event_memberships = EventMembership.joins(:event).where('(event_memberships.user_id= ? AND events.starts_at< ?)', current_user.id, Time.zone.now).includes(event: [:user, :language, comments: [:user]]).order('starts_at DESC').page(params[:page]).per(10)
  end

  def member_attended
    @event = Event.find(@event_membership.event)
    if @event && current_user.author_of?(@event)
      if @event_membership  && @event_membership.event.ends_at < Time.zone.now
        @event_membership.update_columns( attended: true, marked: true)
        render json: { membership_id: @event_membership.id, status: 'attended' }
      else
        render json: { membership_id: @event_membership.id,
                       status: 'not finished',
                       gratitude_text: I18n.t('events.not_finished_yet')
        }
      end
    end
  end

  def member_not_attended
    @event = Event.find(@event_membership.event)
    if @event && current_user.author_of?(@event)
      if @event_membership  && @event_membership.event.ends_at < Time.zone.now
        @event_membership.update_columns( attended: false, marked: true)
        @event_membership.save
        render json: { membership_id: @event_membership.id,
                       status: 'missing',
                       gratitude_text: I18n.t('events.rate_members.you_have_confirmed_absence_of_participant')
        }
      else
        render json: { membership_id: @event_membership.id,
                       status: 'not finished',
                       gratitude_text: I18n.t('events.not_finished_yet')
        }
      end
    end
  end

  def rate_member
    if current_user.can_rate_membership?(@event_membership)
      rated_user = RatedMembership.where(event_membership_id: @event_membership,rated_member_id: @event_membership.user.id).first
      if rated_user
        if rated_user.update(language_level: params[:language_level], activity_level: params[:activity_level]);
          render json: rated_user
        else
          render json: rated_user.errors
        end
      else
        rate_user = current_user.rated_memberships.build(
            rated_member_id: @event_membership.user.id,
            language_level: params[:language_level],
            activity_level: params[:activity_level],
            language_id: @event_membership.event.language.id,
            event_membership: @event_membership
        )
        if rate_user.save
          render json: rate_user
        else
          render json: rate_user.errors
        end
      end
    else
      render json: "{error: can't rate membership}"
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
    def get_membership_for_current_user
      @event_membership = EventMembership.where(user: current_user, event: @event).first
    end

    def get_users_membership
      @event_membership = EventMembership.where(id: params[:id]).first
    end

    def set_page_title
      @page_title = I18n.t('page_titles.event_memberships')
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_membership_params
      params.require(:event_membership).permit(:event_id, :attended)
    end


end
