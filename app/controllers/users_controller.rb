class UsersController < ApplicationController

  def profile
    @department = Department.all
  end

  def ratings
    @department = Department.all
    @students = Student.all
    @passes_affirmative = Array.new
    @passes_negative = Array.new
    affirmative = 0
    negative = 0
    if [1,2,3,4,5,6].include? Time.now.month
      year = [Time.now.year - 1, Time.now.year]
    end
    if params[:date_of] == "0" and params[:date_for] == "0"
      if [10, 12].include? params[:month].to_i
        date_of = "1.#{params[:month]}.#{year[0]}".to_date
        date_for = "31.#{params[:month]}.#{year[0]}".to_date
      elsif [9, 11].include? params[:month].to_i
        date_of = "1.#{params[:month]}.#{year[0]}".to_date
        date_for = "30.#{params[:month]}.#{year[0]}".to_date
      elsif params[:month].to_i == 2
        date_of = "1.#{params[:month]}.#{year[1]}".to_date
        date_for = "28.#{params[:month]}.#{year[1]}".to_date
      elsif [1, 3, 5].include? params[:month].to_i
        date_of = "1.#{params[:month]}.#{year[1]}".to_date
        date_for = "31.#{params[:month]}.#{year[1]}".to_date
      elsif [4, 6].include? params[:month].to_i
        date_of = "1.#{params[:month]}.#{year[1]}".to_date
        date_for = "30.#{params[:month]}.#{year[1]}".to_date
      end
    else
      date_of = params[:date_of].to_date
      date_for = params[:date_for].to_date
    end
    @students.each do |student|
      student.passes.each do |pass|
        if (date_of..date_for).include? pass.date_of
          if pass.cause == "1"
            affirmative = affirmative + pass.hours
          else
            negative = negative + pass.hours
          end
        end
      end
      @passes_affirmative[student.id] = affirmative
      @passes_negative[student.id] = negative
      affirmative = 0
      negative = 0
    end
    @date_of = date_of
    @date_for = date_for
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
