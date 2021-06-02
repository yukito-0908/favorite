class Public::CommentsController < ApplicationController

  def create
    @profile = Profile.find(params[:profile_id])
    @post = Post.find(params[:post_id])
    @comment = Comment.new(comments_params)
    @comment.save
    redirect_to public_profile_post_path(@profile.id,@post.id)
  end

  protected

  def comments_params
    params.require(:comment).permit(:comment_content, :profile_id, :post_id)
  end

end
