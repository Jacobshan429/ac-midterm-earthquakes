class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end


  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.new(params_post)
    if @post.save
      flash[:notice] = "New Post Saved!"
      redirect_to posts_path
    else
      flash[:alert] = "Failed to save!"
      render :new
    end
  end

  private
  def params_post
    params.require(:post).permit(:title, :content, :category_id)
  end
end
