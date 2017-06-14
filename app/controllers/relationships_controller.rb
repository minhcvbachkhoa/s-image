class RelationshipsController < ApplicationController
  before_action :authenticate_user!, only: [:create, :destroy]
  before_action :find_user, only: [:index, :create, :destroy]

  def index
    @type = params[:type] || "following"
    @relationships = @user.send(@type).paginate page: params[:page]
  end

  def create
    @relationship = current_user.follow @user
  end

  def destroy
    current_user.unfollow @user
    @relationship = current_user.active_relationships.build
  end

  private
  def find_user
    @user = User.find_by id: params[:user_id]
    unless @user
      flash[:danger] = t "users.not-found"
      redirect_to root_path
    end
  end
end
