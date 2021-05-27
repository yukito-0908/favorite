class Public::PostsController < ApplicationController

  def index
    @profile = Profile.find(params[:profile_id])
    @post = Post.new
    @posts = Post.all.page(params[:page]).per(10)
  end

  def create
    @profile = Profile.find(params[:profile_id])
    @post = Post.new(posts_params)
    @post.profile_id = @profile.id
  if  @post.save
    redirect_to   public_profile_posts_path(@profile)
  else
    render index
  end
  end

  protected

  def posts_params
    params.require(:post).permit(:title, :genre_name,{images: []},:price,:introduction)
  end
end
