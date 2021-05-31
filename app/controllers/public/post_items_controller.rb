class Public::PostItemsController < ApplicationController

  def destroy
    @profile = Profile.find(params[:profile_id])
    @post = Post.find(params[:post_id])
    @post_item = PostItem.find(params[:id])
    @post_item.destroy
    redirect_to  public_profile_post_path(@profile.id,@post.id)
  end

end
