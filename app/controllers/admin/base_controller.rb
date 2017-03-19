class Admin::BaseController < ApplicationController
  before_action :authorize_user
  before_action :authorize

  layout 'admin'

  private

  def authorize
    # head will send an empty HTTP response and the HTTP code for it will be
    # determined by the first argument you pass. In this case, :unauthorized
    # will send back code `401`. For more codes you can check this page:
    # http://billpatrianakos.me/blog/2013/10/13/list-of-rails-status-code-symbols/
    head :unauthorized unless current_user.is_admin?
  end

  def authorize_user
    if cannot?(:manage, @user)
      redirect_to root_path, alert: 'Not Authorized! Please Sign In'
    end
  end

end
