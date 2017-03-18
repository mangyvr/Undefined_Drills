class CallbackController < ApplicationController
  def twitter
    twitter_data = request.env['omniauth.auth']
    user = User.find_from_oauth(twitter_data)

    if user.nil?
      user ||= User.create_from_oauth(twitter_data)
    end

    session[:user_id] = user.id
    redirect_to root_path, notice: "Thanks for signing up with Twitter!"
  end

  def facebook
    fb_data = request.env['omniauth.auth']
    user = User.find_from_oauth(fb_data)

    if user.nil?
      user ||= User.create_from_oauth(fb_data)
    end

    session[:user_id] = user.id
    redirect_to root_path, notice: 'Thanks for signing in with Facebook!'
  end
end
