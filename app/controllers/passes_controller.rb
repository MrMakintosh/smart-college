class PassesController < ApplicationController

  def index
    @department = Department.all
    @group = Group.first
    @student = @group.students.all
  end

  def add_pass
    @student = Student.find(params[:student])
    @pass_a = @student.passes.new
    @pass_n = @student.passes.new
    @pass_a.date_of_pass = Time.now
    @pass_n.date_of_pass = Time.now
    @pass_a.hours = params[:affirmative_hours]
    @pass_a.cause = "1"
    @pass_a.date_of = params[:date_of].to_date
    @pass_a.date_for = params[:date_for].to_date
    @pass_n.hours = params[:negative_hours]
    @pass_n.cause = "0"
    @pass_n.date_of = params[:date_of].to_date
    @pass_n.date_for = params[:date_for].to_date
    if @pass_a.save and @pass_n.save
      render :json => @student
    end
  end

  private

  def pass_params
    params.require(:pass).permit(:hours, :lesson, :cause)
  end
end
