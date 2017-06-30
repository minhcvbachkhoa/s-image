class LikesController < ApplicationController
  before_action :find_object, only: [:create, :destroy]
  before_action :find_like, only: :destroy

  def create
    @like = current_user.likes.create! likeable: @object
  end

  def destroy
    @like.destroy
  end

  private
  def find_object
    @object = params[:likeable_type].constantize
      .find_by id: params[:likeable_id]
    redirect_to root_path unless @object
  end

  def find_like
    @like = current_user.likes.find_by id: params[:id]
    unless @like
      flash[:danger] = t "error"
      redirect_to root_path
    end
  end
end
