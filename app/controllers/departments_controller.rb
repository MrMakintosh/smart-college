class DepartmentsController < ApplicationController

  def index
    @department = Department.all
  end

  def new
    @department = Department.new
  end

  def show
    @department = Department.find(params[:id])
  end

  def edit
    @department = Department.find(params[:id])
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      flash[:notice] = "Отделение успешно добавлено"
      redirect_to person_root_path
    else
      respond_to.html { redirect_to :action => :new, notice: @department.erorrs }
    end
  end

  def update

  end

  private

  def department_params
    params.require(:department).permit(:name)
  end

end
