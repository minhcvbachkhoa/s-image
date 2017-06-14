class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :find_user, except: [:index]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  before_action :find_relationships, only: :show

  def index
    @users = User.not_admin.paginate page: params[:page]
  end

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "users.updated"
      bypass_sign_in @user
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    flash[:success] = t "users.user-deleted"
    redirect_to root_url
  end

  private
  def user_params
    params.require(:user).permit :email, :name, :avatar, :cover,
      :password, :password_confirmation
  end

  def find_user
    @user = User.find_by id: params[:id]
    unless @user
      flash[:danger] = t "users.not-found"
      redirect_to root_path
    end
  end

  def correct_user
    redirect_to root_path unless @user.current_user? current_user
  end

  def admin_user
    redirect_to root_url if current_user.not_admin?
  end

  def find_relationships
    @supports = Supports::User.new @user
  end
end
