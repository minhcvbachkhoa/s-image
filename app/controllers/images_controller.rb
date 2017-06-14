class ImagesController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :find_image, except: [:index, :new, :create]
  before_action :find_imageable, only: :new

  def index
    @images = Image.all
  end

  def new
    @image = Image.new
  end

  def create
    @image = Image.new image_params
    if @image.save
      flash[:success] = t "images.success-uploaded"
      redirect_to request.referer == root_url ? root_url : @image.object
    else
      respond_to do |format|
        format.html do
          flash[:danger] = t "images.upload-error"
          redirect_to root_path
        end
        format.js
      end
    end
  end

  def show
  end

  def destroy
    obj = @image.object
    if @image.destroy
      flash[:success] = t "images.success-deleted"
      redirect_to obj
    end
  end

  private
  def image_params
    params.require(:image).permit :description, :image, :imageable_id,
      :imageable_type, :category_id
  end

  def find_image
    @image = Image.find_by id: params[:id]
    unless @image
      flash[:danger] = t "images.not-found"
      redirect_to root_path
    end
  end

  def find_imageable
    @imageable = params[:imageable_type].constantize
      .find_by id: params[:imageable_id]
    redirect_to root_path if @imageable.blank?
  end
end
