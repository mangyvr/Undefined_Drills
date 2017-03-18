class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize

 def index
   @drill_count = Drill.count
   @answer_count = Answer.count
   @user_count = User.count
 end

   private

   def authorize
     head :unauthorized unless current_user.is_admin?
   end

end
