class AuthenticationsController < ApplicationController
  def new
    @identity = env['omniauth.identity']
  end

  def failure
    @error = params[:message]
    render :new
  end
  
  def create
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to :root
  end

  def destroy
    session.delete(:user_id)
    redirect_to :root
  end
end