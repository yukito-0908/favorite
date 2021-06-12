class Admins::TagsController < ApplicationController

  def index
     @tags = Post.tag_counts_on(:tags).order('count DESC')
     @posts = Post.all
  if @tag = params[:tag]   # タグ検索用
    @post = Post.tagged_with(params[:tag]).order(id: "DESC").page(1).per(10)   # タグに紐付く投稿
  end
  end

end
