class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_post, :only => [:edit, :update, :destroy]
  def index
    @posts = Post.page(params[:page]).per(5)
  end

  def show
    @post = Post.find(params[:id])
    if params[:edit_comment]
      @comment = Comment.find(params[:edit_comment])
    else
      @comment = Comment.new
    end
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
  end

  def update
    if @post.update(params_post)
      flash[:notice] = "Topic Updated!"
      redirect_to :action => :show
    else
      flash[:alert] = "Fail to update!"
      render :edit
    end
  end

  def destroy
    @post.destroy
    @post.comments.destroy_all
    redirect_to :action => :index
  end

  private
  def params_post
    params.require(:post).permit(:title, :content, :category_id)
  end

  def set_post
    @post = current_user.posts.find(params[:id])
  end
end
