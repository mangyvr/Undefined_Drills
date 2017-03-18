class Admin::DashboardController < Admin::BaseController

  def index
    @drill_count = Drill.count
    @answer_count   = Answer.count
    @user_count     = User.count
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end
  



end

=begin
 step 1: create a users index to dispay all users
 Step 2: create a link for each user to render an show id page for each user
 Step 3: Be able to validate each user & and make user admin user

 class User < ApplicationRecord {
                  :id => :integer,
          :first_name => :string,
           :last_name => :string,
               :email => :string,
            :is_admin => :boolean,
     :password_digest => :string,
        :is_validated => :boolean,
               :score => :integer,
         :token_field => :string,
          :created_at => :datetime,
          :updated_at => :datetime,
                 :uid => :string,
            :provider => :string,
         :oauth_token => :string,
        :oauth_secret => :string,
      :oauth_raw_data => :text
 }

=end
