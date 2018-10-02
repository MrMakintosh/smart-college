class GroupController < ApplicationController
  def index
  end

  def new
    @group = Group.new
    @department = Department.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def edit
    @department = Department.all
    @group = Group.find(params[:id])
  end

  def create
    @specialty = Specialty.find(params[:id])
    @group = @specialty.groups.new(group_params)
    if @group.save
      redirect_to specialty_path(@specialty), notice: "Отделение успешно добавлено"
    else
      respond_to.html { redirect_to :action => :new, notice: @department.erorrs}
    end
  end

  def update
    @group = Group.find(params[:id])
    @old = @group.number
    @specialty = Specialty.find(params[:specialty])
    if @group.update group_params
      @group.update_attributes :specialty_id => params[:specialty]
      redirect_to specialty_path(@specialty), notice: "Группа #{@old} успешно изменена на #{@group.number}"
    end
  end

  def destroy
    @group = Group.find(params[:id])
    if @group
      @group.destroy
      redirect_to "/departments/index"
    else
      redirect_to "/departments/index", notice: @specialty.errors
    end
  end

  private

  def group_params
    params.require(:group).permit(:number)
  end
end
