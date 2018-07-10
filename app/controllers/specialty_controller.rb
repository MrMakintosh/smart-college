class SpecialtyController < ApplicationController
  def index
  end

  def new
    @specialty = Specialty.new
    @department = Department.all
  end

  def edit
    @department = Department.all
    @specialty = Specialty.find(params[:id])
  end

  def create
    @department = Department.find(params[:id])
    @specialty = @department.specialties.new(specialty_params)
    if @specialty.save
      redirect_to "/departments/index", notice: "Специальность успешно добавлена"
    else
      respond_to.html { redirect_to :action => :new, notice: @specialty.erorrs}
    end
  end

  def update
    @specialty = Specialty.find(params[:id])
    @old = @specialty.name
    if @specialty.update specialty_params
      @specialty.update_attributes(:department_id => params[:department])
      redirect_to "/departments/index", notice: "Специальность '#{@old}' была успешно переименована в '#{@specialty.name}'"
    end
  end

  def destroy
    @specialty = Specialty.find(params[:id])
    if @specialty
      @specialty.destroy
      redirect_to "/departments/index"
    else
      redirect_to "/departments/index", notice: @specialty.errors
    end
  end

  private

  def specialty_params
    params.require(:specialty).permit(:name)
  end
end
