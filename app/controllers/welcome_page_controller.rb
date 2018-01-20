class WelcomePageController < ApplicationController
  def index
    @department = Department.all
    @user_session = UserSession.new
  end
end