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
      redirect_to group_path(@group), notice: "Студент успешно добавлен"
    else
      respond_to.html { redirect_to :action => :new, notice: @specialty.erorrs}
    end
  end

  def update
    @group = Group.find(params[:group])
    @student = Student.find(params[:id])
    if @student.update student_params
      @student.update_attributes :group_id => params[:group]
      redirect_to group_path(@group)
    end
  end

  def destroy
    @student = Student.find(params[:id])
    @student.destroy
    redirect_to "/departments/index", notice: "Студент удален"
  end

  def api_request
    @group = Group.find(params[:id])
    @student = @group.students.all
    @passes_affirmative = Array.new
    @passes_negative = Array.new
    affirmative = 0
    negative = 0
    @student.each do |student|
      student.passes.each do |pass|
        if pass.cause == "1"
          affirmative = affirmative + pass.hours
        else
          negative = negative + pass.hours
        end
      end
      @passes_affirmative[student.id] = affirmative
      @passes_negative[student.id] = negative
      affirmative = 0
      negative = 0
    end
    @students = @student.includes(:group).pluck('students.name', 'students.surname', 'students.fathername', 'students.adress', 'groups.number', 'students.id')
    response = { :students => @students, :passes_affirmative => @passes_affirmative, :passes_negative => @passes_negative }
    render :json => response
  end

  def search
    if params[:term]
      @student = Student.search_by_full_name(params[:term])
      @students = @student.includes(:group).pluck('students.name', 'students.surname', 'students.fathername', 'students.adress', 'groups.number', 'students.id')
      @passes_affirmative = Array.new
      @passes_negative = Array.new
      affirmative = 0
      negative = 0
      @student.each do |student|
        student.passes.each do |pass|
          if pass.cause == "1"
            affirmative = affirmative + pass.hours
          else
            negative = negative + pass.hours
          end
        end
        @passes_affirmative[student.id] = affirmative
        @passes_negative[student.id] = negative
        affirmative = 0
        negative = 0
      end
    else
      @students = Student.all
    end
    @passes_affirmative = @passes_affirmative.map {|e| e ? e : 0}
    @passes_negative = @passes_negative.map {|e| e ? e : 0}
    response = { :students => @students, :passes_affirmative => @passes_affirmative, :passes_negative => @passes_negative }
    render :json => response
  end

  private

  def student_params
    params.require(:student).permit(:name, :surname, :fathername, :birthday, :adress)
  end

end
