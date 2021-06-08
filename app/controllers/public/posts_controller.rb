class Public::PostsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @post = Post.new
    @posts = @user.posts.page(params[:page]).per(10)   # 全タグ(Postモデルからtagsカラムを降順で取
    @tags = @posts.tag_counts_on(:tags).most_used(20)    # タグ一覧表示
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}").page(params[:page]).per(10)
    end
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.new(posts_params)
    @post.user_id = @user.id
  if  @post.save!
    redirect_to public_user_posts_path(@user.id)
  else
    render index
  end
  end

  def post_item_create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @post_item = PostItem.new(post_items_params)
    @post_item.post_id  = @post.id
  if  @post_item.save
    redirect_to public_user_post_path(@user.id,@post.id)
  end
  end

  def post_tags
    @user = User.find(params[:user_id])
    @tags = Post.tag_counts_on(:tags).order('count DESC')     # 全タグ(Postモデルからtagsカラムを降順で取得)
    @tag = params[:tag]   # タグ検索用
    @post = Post.tagged_with(params[:tag])   # タグに紐付く投稿
  end


  def show
    @post_item_new = PostItem.new
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @post_tags = @post.tags
    @post_items = @post.post_items
    Like.new
    @likes = @post.likes
    @comment = Comment.new  #投稿詳細画面でコメントの投稿を行うので、formのパラメータ用にCommentオブジェクトを取得
    @comments = @post.comments.order(created_at: :desc)
  end

  def edit
    @user =  User.find(params[:user_id])
    @post = Post.find(params[:id])
  end

  def update
    @user =  User.find(params[:user_id])
    @post = Post.find(params[:id])
    if @post.update(posts_params)
      redirect_to edit_public_user_post_path(@user.id,@post.id)
    else
    render 'edit'
    end
  end


  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to public_user_posts_path(@user.id)
  end



  def post_item_destroy
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @post_item = @post.post_items
    @post_item.destroy_all
    redirect_to edit_public_user_post_path(@user.id,@post)
  end

  def search
    @user = User.find(params[:user_id])
    @posts =  Post.search(params[:user_id],params[:keyword]).page(params[:page]).per(10)
    @keyword = params[:keyword]
    @tags = @posts.tag_counts_on(:tags).most_used(20)    # タグ一覧表示
    @post = Post.new
    if params[:tag_name]
      @posts = Post.tagged_with("#{params[:tag_name]}").page(params[:page]).per(10)
    end
    render "index"
  end

  protected

  def posts_params
    params.require(:post).permit(:title, :genre_name,{images: []},:price,:introduction, :user_id, :tag_list)
  end

  def post_items_params
    params.require(:post_item).permit(:item, :place,{images: []},:introduction,:price, :post_id)
  end
end
