class SessionsController < ApplicationController
  before_action :required_login, except: [:index, :create]
  def index
    #render login page
    render "index"
  end

  def create
    user = User.find_by_email(params[:email]).try(:authenticate, params[:password]) 
    if user
      session[:user_id] = user.id
      redirect_to("/books")
      return
    end
    flash[:errors] = ["Invalid email/password"]
    redirect_to("/")
  end

  def destroy
    session[:user_id] = nil
    redirect_to("/")
  end

end
