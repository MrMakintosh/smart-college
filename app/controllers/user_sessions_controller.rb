class UserSessionsController < ApplicationController

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(user_session_params)
    if @user_session.save
      flash[:success] = "Welcome back!"
      redirect_to root_path
    else
      flash[:alert] = "Неправильный логин или пароль!"
      redirect_to root_path
    end
  end

  def destroy
    current_user_session.destroy
    flash[:success] = "Goodbye!"
    redirect_to root_path
  end

  private

  def user_session_params
    params.require(:user_session).permit(:login, :password, :remember_me)
  end
##TODO: commit "mathematics for user sign_in/sign_out was done. Need styles and front-end at all."
##TODO: need passes realization for students and graphs showed in admin menu (make profile menu different for user and admin)
end
