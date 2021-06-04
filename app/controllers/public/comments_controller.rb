class Public::CommentsController < ApplicationController

  def create
    @profile = Profile.find(params[:profile_id])
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comments_params)
    @comment.profile_id = @profile.id
    @comment.save!
    redirect_to public_profile_post_path(@profile.id,@post.id)
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    render :index
  end

  protected

  def comments_params
    params.require(:comment).permit(:comment_content, :profile_id, :post_id)
  end

end
