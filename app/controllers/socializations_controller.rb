class SocializationsController < ApplicationController
  before_action :authenticate_user!
  before_filter :load_socializable

  def like
    current_user.like!(@socializable)
    @socializable.update(likers_count: @socializable.likers(User).count)
    render json: { object_id: @socializable.id,
                   like: true,
                   likers_count: @socializable.likers_count,
                   btn_class: 'btn-primary',
                   link:  event_unlike_path(@socializable),
                   method: 'delete' }
  end

  def unlike
    current_user.unlike!(@socializable)
    @socializable.update(likers_count: @socializable.likers(User).count)
    render json: { object_id: @socializable.id,
                   like: false,
                   likers_count: @socializable.likers_count,
                   btn_class: 'btn-default',
                   link:  event_like_path(@socializable),
                   method: 'post' }
  end

  private
  def load_socializable
    @socializable =
        case
          when id = params[:event_id] # Must be before :item_id, since it's nested under it.
            Event.find(id)
          else
            raise ArgumentError, 'Unsupported socializable model, params: ' +
                params.keys.inspect
        end
    raise ActiveRecord::RecordNotFound unless @socializable
  end
end
