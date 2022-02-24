class SessionsController < ApplicationController
  def create
    @user = User.find_by(username: params[:user][:username])
    
    if @user and BCrypt::Password.new(@user.password) == params[:user][:password]
      session = @user.sessions.create
      cookies.permanent.signed[:twitter_session_token] = {
        value: session.token,
        httponly: true
      }
      render 'common/success_true'
    else
      render 'common/success_false'
    end
  end

  def authenticated
    token = cookies.permanent.signed[:twitter_session_token]
    session = Session.find_by(token: token)
    if session
      user = session.user
      render json: {
        authenticated: true,
        username: user.username
      }
    else
      render 'sessions/authenticated_false'
    end
  end

  def destroy
    token = cookies.permanent.signed[:twitter_session_token]
    session = Session.find_by(token: token)
    if session and session.destroy
      render 'common/success_true'
    end
  end
end
