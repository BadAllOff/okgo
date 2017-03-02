class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  include Profiled
  include Breadcrumbed
  before_action :set_activity_index_breadcrumb, except: [ :notifications_count ]
  before_action :set_page_title, except: [ :notifications_count ]
  before_action :get_notices, except: [ :notifications_count ]
  after_action :reset_notices_counter, except: [ :notifications_count ]
  after_action :set_notifications_as_read, except: [ :notifications_count ]

  def index
    # TODO Kaminari pagination
    @activities = PublicActivity::Activity.where(id: @notices).order('created_at desc').includes(:trackable, :owner).page(params[:page]).per(25)
    respond_to do |format|
      format.html { @activities }
    end
  end

  def notifications
    if current_user.notices_count > 9
      notices_limit = current_user.notices_count
    else
      notices_limit = 10
    end
    @activities = PublicActivity::Activity.where(id: @notices).order('created_at desc').limit(notices_limit).includes(:trackable, :owner)
    render partial: 'activities/notifications', locals: {activities: @activities}
  end

  def notifications_count
    render current_user.notices_count.to_json
  end

  private

  def set_activity_index_breadcrumb
    add_breadcrumb I18n.t('breadcrumbs.activity.index'), activities_path
  end

  def set_page_title
    @page_title = I18n.t('page_titles.activities')
  end

  def reset_notices_counter
    User.where(id: current_user.id).update(notices_count: 0)
  end

  def get_notices
    @notices = Notice.where(user: current_user).order('created_at desc').limit(10).pluck(:activity_id)
  end

  def set_notifications_as_read
    Notice.where(user: current_user, read: false).update(read_at: Time.zone.now, read: true)
  end
end
