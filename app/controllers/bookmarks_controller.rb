class BookmarksController < ApplicationController
  before_action :authenticate_user!
  before_action :find_user, only: :index
  before_action :find_image, only: [:create, :destroy]
  before_action :find_bookmark, only: :destroy

  def index
    @bookmarks = Image.bookmarked_images(@user).paginate page: params[:page]
  end

  def create
    @bookmark = Like.create! user_id: current_user.id,
      likeable_id: params[:likeable_id], likeable_type: params[:likeable_type]
  end

  def destroy
    @bookmark.destroy
  end

  private
  Settings.metas.each do |meta|
    define_method("find_#{meta.underscore}") do
      instance_variable_set("@#{meta.underscore}",
        meta.constantize.find_by(id: params["#{meta.underscore}_id".to_sym]))
      unless instance_variable_get("@#{meta.underscore}")
        flash[:danger] = t "#{meta.tableize}.not-found"
        redirect_to root_path
      end
    end
  end

  def find_bookmark
    @bookmark = current_user.bookmarks.find_by id: params[:id]
    unless @bookmark
      flash[:danger] = t "users.bookmark-error"
      redirect_to root_path
    end
  end
end
