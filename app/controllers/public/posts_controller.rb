class Public::PostsController < ApplicationController

  def index
    @profile = Profile.find(params[:profile_id])
    @post = Post.new
    @tag_lists = Tag.all
    @posts = Post.all.page(params[:page]).per(10)
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
    @post_tags = @post.tags
  end

def search
  @profile = Profile.find(params[:profile_id])
  @tag_lists = Tag.all  #
  @post = Post.new
  @posts = Post.search(params[:profile_id],params[:keyword]).page(params[:page]).per(10)
  @keyword = params[:keyword]
  render "index"
end

  protected

  def posts_params
    params.require(:post).permit(:title, :genre_name,{images: []},:price,:introduction)
  end
end
