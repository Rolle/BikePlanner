class GroupsController < ApplicationController
  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def edit
    @group = Group.find(params[:id])
  end

  def create
    @group = Group.new(group_params)

    respond_to do |format|
      if @group.save
        redirect_to @group, notice: 'Group was successfully created.'
      else
        render action: "new"
      end
    end
  end

  def update
    @group = Group.find(params[:id])
    respond_to do |format|
      if @group.update_attributes(group_params)
        redirect_to @group, notice: 'Group was successfully updated.' 
      else
        render action: "edit"
      end
    end
  end

  def destroy
    @group = Group.find(params[:id])
    @group.destroy

    redirect_to groups_url
  end

  private
  def group_params
    params.require(:group).permit(:url, :name)
  end
end
