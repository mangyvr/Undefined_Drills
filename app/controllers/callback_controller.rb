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

  # def facebook
  # oauth_data = request.env['omniauth.auth']
  #
  # user = User.where(provider: oauth_data['provider'],
  #                        uid: oauth_data['uid']).first
  #
  # if user.nil?
  #   fullname = oauth_data['info']['name'].split
  #   user = User.create first_name: fullname[0],
  #                    last_name: fullname[1],
  #                        email: oauth_data['info']['email'],
  #                     password: SecureRandom.hex(32),
  #                       avatar: oauth_data['info']['image'],
  #                     provider: oauth_data['provider'],
  #                          uid: oauth_data['uid'],
  #                  oauth_token: oauth_data['credentials']['token'],
  #                 oauth_secret: oauth_data['credentials']['secret'],
  #               oauth_raw_data: oauth_data
  # end
  #
  # session[:user_id] = user.id
  # redirect_to root_path, notice: 'Thanks for signing in with Facebook!'
  # end

end
