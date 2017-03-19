class AnswersController < ApplicationController

  before_action :get_answer_id


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
    render plain: "Answer creation is for admin only"
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
end
