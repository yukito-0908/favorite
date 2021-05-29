class Public::TagsController < ApplicationController

  def show
    @tag = Tag.find(params[:tag_id])  #クリックしたタグを取得
    @posts = @tag.posts.all           #クリックしたタグに紐付けられた投稿を全て表示
    @tag_lists = Tag.all
    @profile = Profile.find(params[:profile_id])
  end
end
