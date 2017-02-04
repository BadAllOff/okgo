class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:update, :destroy]

  authorize_resource

  def create
    @comment = @commentable.comments.new comment_params
    @comment.user = current_user
    if @comment.save
      increment_conters
      respond_to do |format|
        format.html { redirect_to @commentable, notice: t('events.comments.your_comment_was_successfully_posted') }
      end
    end
  end

  def destroy
    if @comment.destroy
      decrement_counters
      respond_to do |format|
        format.html { redirect_to @commentable, notice: t('events.comments.your_comment_was_successfully_destroyed') }
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

  def increment_conters
    @commentable.increment!(:comments_counter)
    current_user.increment!(:comments_counter)
  end

  def decrement_counters
    @commentable.decrement!(:comments_counter)
    current_user.decrement!(:comments_counter)
  end
end
