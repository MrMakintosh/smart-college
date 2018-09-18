class UsersController < ApplicationController

  def profile
    @department = Department.all
  end

  def ratings
    @department = Department.all
    @students = Student.all
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update users_params
      redirect_to users_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def index
    @users = User.all
  end

  def create
    @user = User.new(users_params)
    if @user.save
      flash[:success] = "Account registered!"
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def users_params
    params.require(:user).permit(:login, :password, :password_confirmation, :admin, :name, :surname, :position)
  end

end
