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
      render :controller => :posts, :action => :show
    end
  end


  private

  def params_comment
    params.require(:comment).permit(:content)
  end

end
