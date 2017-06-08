class UsersController < ApplicationController
  before_action :find_user, except: [:index]

  def index
    @users = User.all
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
end
