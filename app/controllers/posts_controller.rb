class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @post = Post.all
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
      render "new"
    end
  end
end
