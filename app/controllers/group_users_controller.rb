class GroupUsersController < ApplicationController
  before_action :authenticate_user!
  before_action :find_group

  def index
    @users = @group.users
  end

  def new
    @users = current_user.following - @group.users
  end

  def create
    add_users_params = Hash.new
    add_users_params[:ids] = group_users_params[:ids]
    add_users_params[:current_user] = current_user
    if @group.add_users add_users_params
      flash[:success] = "Thanh cong"
    else
      flash[:danger] = "That bai"
    end
    redirect_to @group
  end

  def destroy
    @group_user = @group.group_users.find_by id: params[:id]
    if @group_user && @group_user.destroy
      flash[:danger] = "thanh cong"
    else
      flash[:danger] = "That bai"
    end
    redirect_to root_path
  end

  private
  def group_users_params
    params.require(:group_users).permit ids: []
  end

  def find_group
    @group = Group.find_by id: params[:group_id]
    if @group.nil?
      flash[:danger] = "Error"
      redirect_to root_path
    end
  end
end
