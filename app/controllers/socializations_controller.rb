class SocializationsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_socializable

  include Notified

  def like
    current_user.like!(@socializable)
    @socializable.update(likers_count: @socializable.likers(User).count)
    activity = @socializable.create_activity key: "#{@socializable.class.name.downcase}.liked", owner: current_user, recipient: @socializable.user
    notify_followers(activity, @socializable.followers(User))
    render 'socializations/like.json.jbuilder'
  end

  def unlike
    current_user.unlike!(@socializable)
    @socializable.update(likers_count: @socializable.likers(User).count)
    @activity = PublicActivity::Activity.find_by(trackable_id: (@socializable.id), trackable_type: @socializable.class.name)
    @activity.destroy
    render 'socializations/unlike.json.jbuilder'
  end

  private
  def load_socializable
    @socializable =
        case
          when id = params[:event_id] # Must be before :item_id, since it's nested under it.
            Event.find(id)
          when id = params[:feedback_id] # Must be before :item_id, since it's nested under it.
            Feedback.find(id)
          else
            raise ArgumentError, 'Unsupported socializable model, params: ' +
                params.keys.inspect
        end
    raise ActiveRecord::RecordNotFound unless @socializable
  end
end
