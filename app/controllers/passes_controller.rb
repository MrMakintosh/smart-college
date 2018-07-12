class PassesController < ApplicationController

  def add_pass
    @student = Student.find(params[:student])
    @pass = @student.passes.new
    @pass.date_of_pass = Time.now
    @pass.hours = params[:hours]
    @pass.cause = params[:cause]
    if @pass.save
      render :json => @pass
    end
  end

  private

  def pass_params
    params.require(:pass).permit(:hours, :lesson, :cause)
  end
end
