class CommentsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :find_image
  before_action :find_comment, only: [:edit, :update, :destroy]

  def index
    @comments = @image.main_comments
    unless @comments.empty?
      comment_offset = params[:comment_offset] || (@comments.first.id + 1)
      @comments = @comments.show_more_comment comment_offset
    end
  end

  def new
  end

  def create
    @comment = Comment.new comment_params
    @comment.image = @image
    @comment.user = current_user
    @success = @comment.save
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
    params.require(:comment).permit :reply_id, :content, :parent_id
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
