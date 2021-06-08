class Public::CommentsController < ApplicationController

  def create
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comments_params)
    @comment.user_id = @user.id
    @comment_post = @comment.post
    @comment.save!
    @post.create_notification_comment!(current_user, @comment.id)
      # ここまで
    respond_to :js
    render :index
  end

  def destroy
    @user = User.find(params[:user_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.find(params[:id])
    @comment.destroy
    @comments = @post.comments.order(created_at: :desc)
    render :index

  end

  protected

  def comments_params
    params.require(:comment).permit(:comment_content, :profile_id, :post_id)
  end

end
