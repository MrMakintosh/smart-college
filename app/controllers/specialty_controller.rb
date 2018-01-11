class SpecialtyController < ApplicationController
  def index
  end

  def new
  end

  def edit
  end

  def create
    @department = params[:deparment]
    @specialty = @department.specialties.new(specialty_params)
    if @specialty.save
      respond_to.html { redirect_to :action => :index, notice: "Специальность успешно добавлена" }
    else
      respond_to.html { redirect_to :action => :new, notice: @specialty.erorrs}
    end
  end

  private

  def specialty_params
    params.require(:specialties).permit(:name)
  end
end
