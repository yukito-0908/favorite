class Public::PostsController < ApplicationController

  def index
    @profile = Profile.find(params[:profile_id])
    @post = Post.new
    @tag_lists = Tag.all
    @posts = @profile.posts.page(params[:page]).per(10)
  end

  def create
    @profile = Profile.find(params[:profile_id])
    @post = Post.new(posts_params)
    @post.profile_id = @profile.id
    tag_list = params[:post][:tag_ids].split(',')
    @post.save
  if  @post.save_tags(tag_list)
    redirect_to   public_profile_posts_path(@profile.id)
  else
    render index
  end
  end

  def post_item_create
    @post_item = PostItem.new(post_items_params)
    @post = Post.find(params[:post_id])
    @post_item.post_id  = @post.id
  if  @post_item.save
    redirect_to public_profile_post_path(params[:profile_id],@post.id)
  end
  end


  def show
    @post_item_new = PostItem.new
    @profile = Profile.find(params[:profile_id])
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @post_items = @post.post_items
    @likes = @post.likes
    @comments = @post.comments  #投稿詳細に関連付けてあるコメントを全取得
    @comment = @profile.comments.new  #投稿詳細画面でコメントの投稿を行うので、formのパラメータ用にCommentオブジェクトを取得
  end

  def edit
    @profile = Profile.find(params[:profile_id])
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @tag_list = @post.tags.pluck(:tag_name).join(",")
    @post_items = @post.post_items
  end

  def update
    @profile = Profile.find(params[:profile_id])
    @post = Post.find(params[:id])
    tag_list = params[:post][:tag_ids].split(',')
    if @post.update_attributes(posts_params)
      @post.save_tags(tag_list)
      flash[:success] = '投稿を編集しました‼'
      redirect_to  public_profile_post_path(@profile.id,@post.id)
    else
    render 'edit'
    end
  end


  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to public_profile_post_path(@profile.id,@post.id)
  end



  def post_item_destroy_path
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

  def post_items_params
    params.require(:post_item).permit(:item, :place,{images: []},:introduction,:price)
  end
end
