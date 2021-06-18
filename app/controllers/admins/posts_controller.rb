class Admins::PostsController < ApplicationController

  def index
    @user = current_user
    @posts = Post.all.order("id DESC").page(params[:page]).per(10)
  end

  def create
    if params[:admin_ranking] =="1"
      @posts = Post.joins(:likes).group(:post_id).order('count(likes.user_id) desc').page(1).per(10)
    elsif params[:admin_ranking] == "2"
      @posts = Post.joins(:comments).group(:post_id).order('count(comments.user_id) desc').page(1).per(10)
    elsif params[:admin_ranking] == "3"
      @posts = Post.all.order(id: "DESC").page(1).per(10)
    end
    render :index
  end

  def show
    @post = Post.find(params[:id])
    @post_items = @post.post_items
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
  if @post.update(posts_params)
    redirect_to edit_admins_post_path(@post)
  else
    render :edit
  end
  end


  def destroy
    @post = Post.find(params[:id])
  if @post.destroy
    redirect_to  admins_posts_path
  else
    render :edit
  end
  end


  protected

  def posts_params
    params.require(:post).permit(:title, :genre_name,{images: []},:price,:introduction, :user_id, :tag_list, :is_active)
  end

end