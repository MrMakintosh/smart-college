class StudentController < ApplicationController
  def index
    @student = Student.all
  end

  def new
    @student = Student.new
  end

  def edit
  end

  def create
    @group = params[:group]
    @student = @group.students.new(student_params)
    if @student.save
      respond_to.html { redirect_to :action => :index, notice: "Студент успешно добавлен" }
    else
      respond_to.html { redirect_to :action => :new, notice: @specialty.erorrs}
    end
  end

  private

  def student_params
    params.require(:students).permit(:name, :surname, :fathername, :birthday, :adress)
  end

end
