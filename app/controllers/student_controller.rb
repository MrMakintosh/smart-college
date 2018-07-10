class StudentController < ApplicationController
  def index
    @student = Student.all
  end

  def new
    @department = Department.all
    @student = Student.new
  end

  def show
    @student = Student.find(params[:id])
  end

  def edit
    @department = Department.all
    @student = Student.find(params[:id])
  end

  def create
    @group = Group.find(params[:group])
    @student = @group.students.new(student_params)
    if @student.save
      redirect_to "/departments/index", notice: "Студент успешно добавлен"
    else
      respond_to.html { redirect_to :action => :new, notice: @specialty.erorrs}
    end
  end

  def update
    @student = Student.find(params[:id])
    if @student.update student_params
      @student.update_attributes :group_id => params[:group]
      redirect_to "/departments/index"
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    redirect_to "/departments/index", notice: "Студент удален"
  end

  private

  def student_params
    params.require(:student).permit(:name, :surname, :fathername, :birthday, :adress)
  end

end
