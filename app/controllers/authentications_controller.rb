class AuthenticationsController < ApplicationController
  def new
    @identity = env['omniauth.identity']
  end

  def failure
    render :new
  end
  
  def create
    auth = request.env['omniauth.auth']
    user = User.from_omniauth(auth)
    session[:user_id] = user.id
    redirect_to :root
  end

  def destroy
    session[:user_id] = nil
    redirect_to :root
  end
end