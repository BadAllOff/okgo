class Feedbacks::CommentsController < CommentsController
  before_action :set_commentable

  private

  def set_commentable
    @commentable = Feedback.find(params[:feedback_id])
  end
end