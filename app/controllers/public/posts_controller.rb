class Public::PostsController < ApplicationController

  def index
    @profile = Profile.find(params[:profile_id])
    @post = Post.new
    @tag_list = Tag.all
    @posts = Post.all.page(params[:page]).per(10)
    @post_tags = @post.tags
  end

  def create

    @profile = Profile.find(params[:profile_id])
    @post = Post.new(posts_params)
    @post.profile_id = @profile.id
   tag_list = params[:post][:tag_ids].split(',')
    @post.save
  if  @post.save_tag(tag_list)
    redirect_to   public_profile_posts_path(@profile)
  else
    render index
  end
  end

  def show
    @profile = Profile.find(params[:profile_id])
    @post = Post.find(params[:id])
  end

  protected

  def posts_params
    params.require(:post).permit(:title, :genre_name,{images: []},:price,:introduction)
  end
end
