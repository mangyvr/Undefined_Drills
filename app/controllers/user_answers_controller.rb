class UserAnswersController < ApplicationController
  before_action :find_user

  def create
    @drill = Drill.find params[:drill_id]
    user_drill_status = UserDrill.where(drill: @drill, user: current_user)[0] || UserDrill.new(drill: @drill, user: current_user, completed: false, attempts: 0)
    correct_answers = @drill.answers
    user_answer = params[:user_answer]
    correct = false
    correct_answers.each do |answer|
      if answer.body.downcase == user_answer.downcase &&
        correct = true
      end
      p answer.body.downcase + ' - ' + params[:user_answer].downcase
    end

    if user_drill_status.completed === false
      user_drill_status.attempts += 1
      if (correct == true && user_drill_status.completed === false)
        user_drill_status.completed = true
        @user.score = @user.score + @drill.points
        @user.save
      end
      user_drill_status.save
      p current_user
      p "current_user_completed_percentage is: "
      p current_user.completed_percentage(@drill.group)
      if current_user.completed_percentage(@drill.group) == 1.to_f
        ugp = UserGroupPermission.new
        p "ugp is: "
        p ugp
        ugp.user = current_user
        ugp.group = @drill.group
        ugp.save
      end
    end
    redirect_to drill_path(@drill, body: user_answer), correct == true ? {notice: "You answered correctly."} : {alert: "Sorry, that's incorrect.  Please try again."}

  end

  private

  def find_user
    @user = User.find current_user
  end

end
