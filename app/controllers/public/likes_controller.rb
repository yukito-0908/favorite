class Public::LikesController < ApplicationController

  def index
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @like = Like.find_by(post_id: params[:post_id], user_id: params[:user_id])
    @like.destroy
    @likes = @post.likes
  end

  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @like = @user.likes.build(post_id: @post.id,user_id: @user.id)
    @like.save!
    @likes = @post.likes
  end

end
