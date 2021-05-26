class Public::PostsController < ApplicationController

  def index
    @post = Post.new
    @posts = Post.all

  end

  def create
    @post = Post.new(posts_params)
    @profile = current_user.profiles
    @post.save!
    @posts = Post.all
  end

  protected

  def posts_params
    params.require(:post).permit(:title, :genre_name)
  end
end
