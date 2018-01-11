class GroupController < ApplicationController
  def index
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    @specialty = params[:specialty]
    @group = @specialty.groups.new(group_params)
    if @group.save
      respond_to.html { redirect_to :action => :index, notice: "Отделение успешно добавлено" }
    else
      respond_to.html { redirect_to :action => :new, notice: @department.erorrs}
    end
  end

  private

  def group_params
    params.require(:groups).permit(:number)
  end
end
