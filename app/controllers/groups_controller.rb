class GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :find_group, except: [:index, :new, :create]
  before_action :is_admin_group?, only: [:edit, :update, :destroy]
  before_action :find_supports, only: :show
  before_action :find_user, only: :index

  def index
    @groups =
      if @user.current_user? current_user
        @user.groups
      else
        @user.groups.is_public
      end
  end

  def new
    @group = Group.new
  end

  def show
  end

  def create
    @group = Group.new group_params
    if @group.save
      GroupUser.create! group_id: @group.id,
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

  def edit
  end

  def update
    if @group.update_attributes group_params
      flash[:success] = t "groups.group-updated"
      redirect_to @group
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    flash[:success] = t "groups.group-deleted"
    redirect_to root_url
  end

  private
  def find_group
    @group = Group.find_by id: params[:id]
    return if @group
    flash[:warning] = t "groups.not-found"
    redirect_to root_path
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

  def find_supports
    @supports = Supports::Group.new @group
  end

  def find_user
    @user = User.find_by id: params[:user_id]
    return if @user
    flash[:warning] = t "users.not-found"
    redirect_to root_path
  end
end
