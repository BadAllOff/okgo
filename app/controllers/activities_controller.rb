class ActivitiesController < ApplicationController
  before_action :authenticate_user!
  include Profiled
  include Breadcrumbed
  before_action :set_activity_index_breadcrumb
  before_action :set_page_title

  def index
    @notices = Notice.where(user: current_user).order('created_at desc').limit(10).pluck(:activity_id)
    @activities = PublicActivity::Activity.where(id: @notices).order('created_at desc').includes(:trackable, :owner)
  end

  private

  def set_activity_index_breadcrumb
    add_breadcrumb I18n.t('breadcrumbs.activity.index'), activities_path
  end

  def set_page_title
    @page_title = I18n.t('page_titles.activities')
  end
end
