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

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(params_post)
      flash[:notice] = "Topic Updated!"
      redirect_to :action => :show
    else
      flash[:alert] = "Fail to update!"
      render :edit
    end
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy
    redirect_to :action => :index
  end

  private
  def params_post
    params.require(:post).permit(:title, :content, :category_id)
  end
end
