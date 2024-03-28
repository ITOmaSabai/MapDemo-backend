class Api::V1::FeedbacksController < ApplicationController

  def index
    feedbacks = Feedback.all
  end

  def create
    feedback = Feedback.new(feedback_params)
    if feedback.save!
      render json: {feedback: feedback, status: :created}
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:usability_rating, :design_rating, :body)
  end
end
