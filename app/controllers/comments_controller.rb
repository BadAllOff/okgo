class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:update, :destroy]

  authorize_resource
  include Notified

  def create
    @comment = @commentable.comments.new comment_params
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        increment_conters
        current_user.follow!(@commentable)
        # Save record about activity
        save_activity_record(@commentable)

        format.json { render partial: 'comments/create.json.jbuilder'}
        format.html { redirect_to @commentable, flash: { success: t('comments.your_comment_was_successfully_posted') }}
      else
        format.json { render partial: 'comments/error.json.jbuilder', status: 422}
      end
    end
  end

  def destroy
    if @comment.destroy
      decrement_counters
      respond_to do |format|
        format.json { render partial: 'comments/destroy.json.jbuilder'}
        format.html { redirect_to @commentable, flash: { success: t('comments.your_comment_was_successfully_destroyed') }}
      end
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def save_activity_record(commentable)
    activity = commentable.create_activity key: "#{commentable.class.name.downcase}.comment.create", owner: current_user
    notify_followers(activity, commentable.followers(User))
  end

  def increment_conters
    @commentable.increment!(:comments_count)
    current_user.increment!(:comments_count)
  end

  def decrement_counters
    @commentable.decrement!(:comments_count)
    current_user.decrement!(:comments_count)
  end
end
