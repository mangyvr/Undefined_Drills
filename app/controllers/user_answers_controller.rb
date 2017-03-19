class UserAnswersController < ApplicationController

  def create
    @drill = Drill.find params[:drill_id]
    correct_answers = @drill.answers
    correct = false
    correct_answers.each do |answer|
      if answer.body.downcase == params[:user_answer].downcase
        correct = true
      end
    end

    if correct = true
      


    end

    render json: correct

  end
end
