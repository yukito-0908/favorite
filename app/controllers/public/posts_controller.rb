class Public::PostsController < ApplicationController

  def index
    @posts = Post.all
    @post = Post.new
  end

  def create
    @post = Post.new(posts_params)
    @posts = Post.all
  end

  protected

  def posts_params
    params.require(:post).permit(:instagram_id, :name, :introduction, :image ,:is_active, :user_id)
  end
end
