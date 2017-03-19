class UserAnswersController < ApplicationController

  def create
    @drill = Drill.find params[:drill_id]
    user_drill_status = UserDrill.where(drill: @drill, user: current_user)[0] || UserDrill.new(drill: @drill, user: current_user, completed: false, attempts: 0)
    correct_answers = @drill.answers
    correct = false
    correct_answers.each do |answer|
      if answer.body.downcase == params[:user_answer].downcase
        correct = true
      end
      p answer.body.downcase + ' - ' + params[:user_answer].downcase
    end

    if user_drill_status.completed == false
      user_drill_status.attempts += 1
      if correct == true
        user_drill_status.completed = true
      end
      user_drill_status.save
    end

    redirect_to drill_path(@drill), correct == true ? {notice: "You answered correctly."} : {alert: "Sorry, that's incorrect.  Please try again."}

  end
end
