class GroupsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_group, except: [:index, :new, :create]
  before_action :is_admin_group?, only: [:edit, :update, :destroy, :show]

  def show
    @images = @group.images
    @users = @group.users
  end

  def new
    @group = Group.new
  end

  def create
    @group = Group.new group_params
    if @group.save
      @group_user = GroupUser.create! group_id: @group.id,
        user_id: current_user.id, admin_group: true
      flash[:success] = t "groups.group-created"
      redirect_to @group
    else
      respond_to do |format|
        format.html do
          flash[:danger] = t "groups.error"
          redirect_to root_path
        end
        format.js
      end
    end
  end

  private
  def find_group
    @group = Group.find_by id: params[:id]
    unless @group
      flash[:warning] = t "groups.group-not-found"
      redirect_to root_path
    end
  end

  def group_params
    params.require(:group).permit :name, :policy, :avatar, :cover
  end

  def is_admin_group?
    unless current_user.is_admin_group? @group
      flash[:warning] = t "groups.not-admin-group"
      redirect_to @group
    end
  end
end
