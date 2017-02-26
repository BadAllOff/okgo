class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  include Profiled
  include Breadcrumbed
  before_action :set_activity_index_breadcrumb
  before_action :set_page_title
  before_action :get_notices
  after_action :reset_notices_counter
  after_action :set_notifications_as_read

  def index
    @activities = PublicActivity::Activity.where(id: @notices).order('created_at desc').includes(:trackable, :owner)
    respond_to do |format|
      format.html { @activities }
    end
  end

  def notifications
    @activities = PublicActivity::Activity.where(id: @notices).order('created_at desc').includes(:trackable, :owner)
  end

  private

  def set_activity_index_breadcrumb
    add_breadcrumb I18n.t('breadcrumbs.activity.index'), activities_path
  end

  def set_page_title
    @page_title = I18n.t('page_titles.activities')
  end

  def reset_notices_counter
    User.reset_counters(current_user.id, :notices)
  end

  def get_notices
    @notices = Notice.where(user: current_user).order('created_at desc').limit(10).pluck(:activity_id)
  end

  def set_notifications_as_read
    Notice.where(user: current_user, read: false).update(read_at: Time.zone.now, read: true)
  end
end
