class AlbumsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :find_album, except: [:index, :new, :create]
  before_action :correct_user?, only: [:edit, :update, :destroy]
  before_action :find_user, only: :index

  def index
    @albums = @user.albums
  end

  def new
    @album = Album.new
    @image = @album.images.build
  end

  def show
  end

  def create
    @album = Album.new album_params
    if @album.save
      if params[:images].present?
        params[:images]["image"].each do |img|
          Image.create! image: img, category_id: Category.first.id,
            imageable: @album
        end
      end
      flash[:success] = t "album-created"
      redirect_to @album
    else
      respond_to do |format|
        format.html do
          flash[:danger] = t "create-album-error"
          redirect_to root_path
        end
        format.js
      end
    end
  end

  def update
    if @album.update_attributes album_params
      flash[:success] = t "name-album-updated"
      redirect_to @album
    end
  end

  def destroy
    if @album.destroy
      flash[:success] = t "album-deleted"
      redirect_to request.referer
    else
      flash[:danger] = t "error"
      redirect_to root_path
    end
  end

  private
  def find_album
    @album = Album.find_by id: params[:id]
    return if @album
    flash[:warning] = t "album-not-found"
    redirect_to root_path
  end

  def album_params
    params.require(:album).permit :name, :user_id,
      images_attributes: [:imageable_id, :imageable_type, :image,
      :description, :category_id]
  end

  def correct_user?
    redirect_to root_path unless @album.user.current_user? current_user
  end

  def find_user
    @user = User.find_by id: params[:user_id]
    return if @user
    flash[:warning] = t "users.not-found"
    redirect_to root_path
  end
end
