class SessionsController < ApplicationController
  
  def index
    respond_to do |format|
      format.html # index.html.erb
    end
  end
  
  def create
    user = User.from_omniauth(env["omniauth.auth"])
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> USER auth"
    puts env["omniauth.auth"]
    puts ">>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> USER"
    session[:user_id] = user.id
    redirect_to root_url, notice: "Signed in!"
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Signed out!"
  end
end