class Public::LikesController < ApplicationController

  def create
    @user = current_user
    @post = Post.find(params[:post_id])
   @like = Like.new(post_id: @post.id,user_id: @user.id)
   @like.save
    redirect_to   public_user_post_path(@user.id,@post.id)
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @like = Like.find_by(post_id: params[:post_id], profile_id: params[:profile_id])
    @like.destroy
    redirect_to public_profile_post_path(@profile.id,@post.id)
  end

end
