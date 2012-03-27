class HomeController < ApplicationController
  def index
    @users = User.sort(:created_at.desc).all
  end
end
