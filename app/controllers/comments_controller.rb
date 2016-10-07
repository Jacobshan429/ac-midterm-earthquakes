class CommentsController < ApplicationController

  def create
    @post = Post.find(params[:post_id])
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
    @post = current_user.posts.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    if @comment.update(params_comment)
      flash[:notice] = "Updated Comment Succeed!"
      redirect_to post_path(@post)
    else
      flash[:alert] = "Failed!"
      redirect_to post_path(@post)
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to post_path(@post)
  end



  private

  def params_comment
    params.require(:comment).permit(:content)
  end

end
