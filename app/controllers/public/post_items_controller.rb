class Public::PostItemsController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
  end

  def destroy
    @profile = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @post_item = PostItem.find(params[:id])
    @post_item.destroy
    redirect_to  public_profile_post_path(@user.id,@post.id)
  end

end
