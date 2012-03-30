class UsersController < ApplicationController
  def edit
  end

  def save
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = 'Profile updated!'
      redirect_to :show_profile
    else
      render :edit
    end
  end
end
