class FeedbacksController < ApplicationController
  before_action :authenticate_user!, only: [:create, :edit, :update, :destroy]
  include Profiled
  include Breadcrumbed

  authorize_resource

  before_action :set_feedback_index_breadcrumb
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]
  before_action :set_page_title

  # GET /feedbacks
  # GET /feedbacks.json
  def index
    @feedbacks = Feedback.order(created_at: 'desc').includes(:comments, user: [:profile]).page(params[:page]).per(20)
  end

  # GET /feedbacks/1
  # GET /feedbacks/1.json
  def show
  end

  # GET /feedbacks/new
  def new
    @feedback = Feedback.new
  end

  # GET /feedbacks/1/edit
  def edit
  end

  # POST /feedbacks
  # POST /feedbacks.json
  def create
    @feedback = current_user.feedbacks.build(feedback_params)

    respond_to do |format|
      if @feedback.save
        format.html { redirect_to @feedback, notice: 'Feedback was successfully created.' }
        format.json { render :show, status: :created, location: @feedback }
      else
        format.html { render :new }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /feedbacks/1
  # PATCH/PUT /feedbacks/1.json
  def update
    respond_to do |format|
      if @feedback.update(feedback_params)
        format.html { redirect_to @feedback, notice: 'Feedback was successfully updated.' }
        format.json { render :show, status: :ok, location: @feedback }
      else
        format.html { render :edit }
        format.json { render json: @feedback.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /feedbacks/1
  # DELETE /feedbacks/1.json
  def destroy
    @feedback.destroy
    Follow.remove_followers(@feedback)
    respond_to do |format|
      format.html { redirect_to feedbacks_url, notice: 'Feedback was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def feedback_params
      params.require(:feedback).permit(:feedback, :status)
    end

    def set_feedback_index_breadcrumb
      add_breadcrumb I18n.t('breadcrumbs.feedback.index'), feedbacks_path
    end

    def set_page_title
      @page_title = I18n.t('page_titles.feedbacks')
    end
end
