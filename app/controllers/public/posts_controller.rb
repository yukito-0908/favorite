class Public::PostsController < ApplicationController

  def index
    @post = Post.new
    @posts = Post.all
    @profile = Profile.find(params[:profile_id])


  end

  def create
    @profile = Profile.find(params[:profile_id])
    @post = Post.new(posts_params)
    @post.profile_id = @profile.id
    @post.save
    @posts = Post.all
  end

  protected

  def posts_params
    params.require(:post).permit(:title, :genre_name)
  end
end
