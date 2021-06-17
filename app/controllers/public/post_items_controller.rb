class Public::PostItemsController < ApplicationController


  def show
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @post_item = PostItem.find(params[:id])
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @post_item = PostItem.find(params[:id])
    @post_item.destroy
    redirect_to  edit_public_user_post_path(@user.id,@post.id)
  end

  protected

  def post_items_params
    params.require(:post_item).permit()
  end

end
