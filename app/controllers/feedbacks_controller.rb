class Api::V1::FeedbacksController < ApplicationController
  def create
    feedback = Feedback.new(feedback_params)
    if feedback.create
      render json :feedback: feedback, status: :created
    end
  end

  private

  def feedback_params
    params.require(:feedback).permit(:usability_rating, :design_rating, :body)
end
