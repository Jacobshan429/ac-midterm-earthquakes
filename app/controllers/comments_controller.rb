class CommentsController < ApplicationController
  before_action :set_post
  before_action :set_comment, :only => [:update, :destroy]
  def create
    @comment = @post.comments.new(params_comment)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:notice] = "Commented Saved!"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Failed!"
      redirect_to post_path(@post)
    end
  end

  def update
    if @comment.update(params_comment)
      flash[:notice] = "Updated Comment Succeed!"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Failed!"
      redirect_to post_path(@post)
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path(@post)
  end



  private

  def params_comment
    params.require(:comment).permit(:content)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = current_user.comments.find(params[:id])
  end

end
