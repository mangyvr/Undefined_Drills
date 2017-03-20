class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :get_answer_id, except: [:new, :create, :index]
  # before_action :authorize

  def index
    render plain: "Is this required?"
  end

  def show
    render plain: "Is this required?"
  end

  def new
    render plain: "For Admin Use Only"
  end

  def create
    p json: params
    @drill = Drill.find params[:drill_id]
    answer_params = params.require(:answer).permit(:body)
    answer_params[:approved] = current_user.is_admin? ? true : false
    answer_params[:user] = current_user
    answer_params[:drill] = @drill
    @answer = Answer.create(answer_params)
    redirect_to drill_path(@drill, body: @answer.body), @answer.approved ?
    {notice: "The answer has been successfully created"} : {notice: "Your answer has been submitted for review!"}
  end

  def edit
    render plain: "For Admin Use Only"
  end

  def update
  end

  def destroy
  end


  private

  def get_answer_id
    @answer = Answer.find params[:id]
  end

  def authorize
    if cannot?(:manage, @answer)
      redirect_to root_path, alert: 'Not authorized!'
    end
  end

end
