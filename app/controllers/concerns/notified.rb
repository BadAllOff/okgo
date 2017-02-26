# Ability to get create notifications about activities to followers
module Notified
  extend ActiveSupport::Concern

  private

  def notify_followers(activity, followers)
    followers.each do |follower|
      notice = Notice.new(activity: activity, user: follower);
      notice.save! unless current_user.id == follower.id
    end
  end
end
