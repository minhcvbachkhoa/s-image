class CommentsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :find_image, except: [:create, :new]
  before_action :find_comment, only: [:edit, :update, :destroy]

  def index
    @comments = @image.comments.hash_tree(limit_depth: Settings.limit_depth)
    @comments.delete_if{|root, _replys| root.id >= params[:offset].to_i}
  end

  def new
    @comment = Comment.new parent_id: params[:parent_id]
  end

  def create
    @comment = Comment.create comment_params
  end

  def edit
  end

  def update
    @comment.update_attributes comment_params
  end

  def destroy
    @comment.destroy
  end

  private
  def comment_params
    params.require(:comment).permit :content, :parent_id, :image_id, :user_id
  end

  def find_image
    @image = Image.find_by id: params[:image_id]
    unless @image
      flash[:danger] = t "images.not-found"
      redirect_to root_path
    end
  end

  def find_comment
    @comment = Comment.find_by id: params[:id]
    unless @comment
      flash[:danger] = t "comments.not-found"
      redirect_to root_path
    end
  end
end
