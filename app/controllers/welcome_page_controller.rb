class WelcomePageController < ApplicationController
  def index
    @department = Department.all
  end
end