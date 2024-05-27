class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def edit
    @post = Post.find(params[:id])
    if current_user.id != @post.user_id
      redirect_to posts_path
    end
  end

  def update
    @post = Post.find(params[:id])
    if current_user.id != @post.user_id
      redirect_to posts_path
    else
      if @post.update(post_params)
        redirect_to posts_path
      else
        render :edit
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :content, :answers_count)
  end
end
