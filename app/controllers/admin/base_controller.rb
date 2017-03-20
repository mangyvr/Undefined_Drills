class Admin::BaseController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize

  layout 'admin'

  private

  def authorize
    # head will send an empty HTTP response and the HTTP code for it will be
    # determined by the first argument you pass. In this case, :unauthorized
    # will send back code `401`. For more codes you can check this page:
    # http://billpatrianakos.me/blog/2013/10/13/list-of-rails-status-code-symbols/
    redirect_to (user_sign_in? ? stats_user_path(current_user) : new_session_path), alert: "You do not authority for that action" unless current_user&.is_admin?
  end

end
