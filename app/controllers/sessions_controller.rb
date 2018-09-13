class SessionsController < ApplicationController
  def new
    render :new
  end
  
  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user
      login_user!(@user)
      redirect_to cats_url
    else
      username_test = User.find_by(username: params[:user][:username])
        if username_test
          flash.now[:errors] = ['Invalid password']
        else
          flash.now[:errors] = ['Invalid user/password']
        end
      render :new
    end
  end
  
  def destroy
    logout_user!
    redirect_to session_url
  end
end