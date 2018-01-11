class DepartmentController < ApplicationController

  def index
    @department = Department.all
  end

  def new
    @department = Department.new
  end

  def edit
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      respond_to.html { redirect_to :action => :index, notice: "Отделение успешно добавлено" }
    else
      respond_to.html { redirect_to :action => :new, notice: @department.erorrs }
    end
  end

  private

  def department_params
    params.require(:departments).permit(:name)
  end

end
