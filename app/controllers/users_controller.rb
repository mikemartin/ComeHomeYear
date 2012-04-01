class UsersController < ApplicationController
  def edit
  end

  def crop
  end

  def save
    if current_user.update_attributes(params[:user])
      flash[:notice] = 'Profile updated!'
      if params[:user][:photo].blank?
        redirect_to :show_profile
      else
        render :action => :crop
      end
    else
      render :edit
    end
  end
end