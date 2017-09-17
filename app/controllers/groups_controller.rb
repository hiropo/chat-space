class GroupsController < ApplicationController
 before_action :find_group_by_id, only: [:edit, :update]

  def index
    @groups = current_user.groups
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      redirect_to root_path, notice: 'グループを作成しました'
    else
      render new_group_path
    end
  end

  def update
    @group = find_group_by_id
    @group.update(group_params)
    redirect_to root_path
  end

  def edit
    @group = find_group_by_id
  end
    
  private
  def group_params
      params.require(:group).permit(:name, user_ids: [])
  end

  def find_group_by_id
    Group.find(params[:id])
  end
end
