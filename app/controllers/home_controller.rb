class HomeController < ApplicationController
  def index
    query = User.sort(:created_at.desc)

    if session[:user_id]
      @users = query.all(:id => {:$ne => session[:user_id]})
    else
      @users = query.all
    end

    @mapData = query.where(:coords => {:$size => 2}).to_json(:only => [:full_name, :coords])
  end
end
