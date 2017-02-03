class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: [:destroy]

  authorize_resource

  def create
    @comment = @commentable.comments.new comment_params
    @comment.user = current_user
    if @comment.save
      redirect_to @commentable, notice: "Your comment was successfully posted."
    end
  end

  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @commentable, notice: "Your comment was successfully destroyed." }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end
end
