class SessionsController < ApplicationController
  def new
  end
  
  def create
    if params[:provider] == 'facebook'
      user = User.from_omniauth(env["omniauth.auth"])
      session[:user_id] = user.id
      redirect_back_or user
    else
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        sign_in user
        redirect_back_or user
      else
        flash[:error] = 'Invalid email/password combination'
        redirect_to root_url
      end
    end
  end
  
  def destroy
    sign_out
    redirect_to root_url
  end
end
